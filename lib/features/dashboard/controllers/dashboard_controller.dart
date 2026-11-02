// import 'package:flutter/foundation.dart';
// import '../data/dashboard_repository.dart';
// import '../models/dashboard_data.dart';
//
// class DashboardController extends ChangeNotifier {
//   DashboardController(this._repo);
//   final DashboardRepository _repo;
//
//   DashboardData? _data;
//   bool _isLoading = false;
//   String? _error;
//
//   DashboardData? get data => _data;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//
//   /// Pass [listId] / [listName] to load a specific list; omit for the first list.
//   Future<void> load(String userId, {String? listId, String? listName}) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       _data = await _repo.fetchDashboard(userId, listId: listId, listName: listName);
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import '../data/dashboard_repository.dart';
import '../models/dashboard_data.dart';

class DashboardController extends ChangeNotifier {
  DashboardController(this._repo);
  final DashboardRepository _repo;

  DashboardData? _data;
  bool _isLoading = false;
  String? _error;
  bool _listSelected = false;

  DashboardData? get data => _data;
  bool get isLoading => _isLoading;
  String? get error => _error;


  bool get listSelected => _listSelected;

  Future<void> load(String userId, {String? listId, String? listName}) async {
    if (listId != null) _listSelected = true;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _data = await _repo.fetchDashboard(userId, listId: listId, listName: listName);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}