// import '../models/dashboard_data.dart';
//
// enum DashboardScenario { loaded, empty }
//
// /// Dummy implementation. Replace [fetchDashboard] with the real API later.
// class DashboardRepository {
//   /// Change to [DashboardScenario.empty] to preview the empty dashboard.
//   static const DashboardScenario scenario = DashboardScenario.loaded;
//
//   Future<DashboardData> fetchDashboard() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     if (scenario == DashboardScenario.empty) {
//       return const DashboardData(
//         listName: 'Test List',
//         stats: CallStats(total: 0, pending: 0, done: 0, scheduled: 0),
//       );
//     }
//     return const DashboardData(
//       listName: 'Test List',
//       stats: CallStats(total: 50, pending: 28, done: 22, scheduled: 9),
//     );
//   }
// }

// import 'package:flutter/foundation.dart';
// import '../../../core/network/api_client.dart';
// import '../models/dashboard_data.dart';
//
// class DashboardRepository {
//   Future<DashboardData> fetchDashboard(String userId) async {
//     const empty = DashboardData(
//       listName: '',
//       stats: CallStats(total: 0, pending: 0, done: 0, scheduled: 0),
//     );
//
//     final listsRes = await ApiClient.instance.get('/GetListsV4', query: {'userid': userId});
//     debugPrint('LISTS RESPONSE: $listsRes');
//     final Map lists = listsRes is Map ? listsRes : {};
//     final List items = lists['Data'] is List ? lists['Data'] as List : [];
//     if (lists['StatusCode'].toString() != '1' || items.isEmpty) return empty;
//
//     final first = items.first as Map;
//     final listId = first['ListId'].toString();
//     final listName = (first['ListName'] ?? '').toString();
//
//     final detailsRes = await ApiClient.instance
//         .get('/GetListDataV7', query: {'userid': userId, 'listid': listId});
//     debugPrint('LIST DETAILS RESPONSE: $detailsRes');
//     final Map details = detailsRes is Map ? detailsRes : {};
//     final List contacts = details['Data'] is List ? details['Data'] as List : [];
//     if (contacts.isEmpty) return empty;
//
//     // TEMPORARY: every contact counts as pending until we know the status field.
//     return DashboardData(
//       listName: listName,
//       stats: CallStats(
//         total: contacts.length,
//         pending: contacts.length,
//         done: 0,
//         scheduled: 0,
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import '../../../core/network/api_client.dart';
import '../models/dashboard_data.dart';

class DashboardRepository {
  static const _empty = DashboardData(
    listName: '',
    stats: CallStats(total: 0, pending: 0, done: 0, scheduled: 0),
  );

  /// If [listId] is null, the first list from the API is used.
  Future<DashboardData> fetchDashboard(
      String userId, {
        String? listId,
        String? listName,
      }) async {
    var id = listId;
    var name = listName ?? '';

    if (id == null) {
      final listsRes =
      await ApiClient.instance.get('/GetListsV4', query: {'userid': userId});
      debugPrint('LISTS RESPONSE: $listsRes');
      final Map lists = listsRes is Map ? listsRes : {};
      final List items = lists['Data'] is List ? lists['Data'] as List : [];
      if (lists['StatusCode'].toString() != '1' || items.isEmpty) return _empty;

      final first = items.first as Map;
      id = first['ListId'].toString();
      name = (first['ListName'] ?? '').toString();
    }

    final detailsRes = await ApiClient.instance
        .get('/GetListDataV7', query: {'userid': userId, 'listid': id});
    debugPrint('LIST DETAILS RESPONSE: $detailsRes');
    final Map details = detailsRes is Map ? detailsRes : {};
    final List contacts = details['Data'] is List ? details['Data'] as List : [];

    if (contacts.isEmpty) {
      return DashboardData(
        listName: name,
        stats: const CallStats(total: 0, pending: 0, done: 0, scheduled: 0),
      );
    }

    // TEMPORARY: every contact counts as pending until we know the status field.
    return DashboardData(
      listName: name,
      stats: CallStats(
        total: contacts.length,
        pending: contacts.length,
        done: 0,
        scheduled: 0,
      ),
    );
  }
}