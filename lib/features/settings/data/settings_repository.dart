// import '../models/calling_list.dart';
//
// /// Dummy implementation. Replace with real API calls later.
// class SettingsRepository {
//   Future<List<CallingList>> fetchCallingLists() async {
//     await Future.delayed(const Duration(milliseconds: 600));
//     return const [CallingList(id: '1', name: 'Test List')];
//   }
// }


import 'package:flutter/foundation.dart';
import '../../../core/network/api_client.dart';
import '../models/calling_list.dart';

class SettingsRepository {
  Future<List<CallingList>> fetchCallingLists(String userId) async {
    final res = await ApiClient.instance.get('/GetListsV4', query: {'userid': userId});
    debugPrint('CALLING LISTS RESPONSE: $res');

    final Map data = res is Map ? res : {};
    if (data['StatusCode'].toString() != '1' || data['Data'] is! List) return [];

    return (data['Data'] as List).map((e) {
      final item = e as Map;
      return CallingList(
        id: item['ListId'].toString(),
        name: (item['ListName'] ?? '').toString(),
      );
    }).toList();
  }
}
