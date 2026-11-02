// import 'package:flutter/foundation.dart';
// import '../data/settings_repository.dart';
// import '../models/calling_list.dart';
//
// class SettingsController extends ChangeNotifier {
//   SettingsController(this._repo);
//   final SettingsRepository _repo;
//
//   List<CallingList> _lists = [];
//   CallingList? _selected;
//   bool _isLoading = false;
//
//   List<CallingList> get lists => _lists;
//   CallingList? get selected => _selected;
//   bool get isLoading => _isLoading;
//
//   Future<void> load() async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       _lists = await _repo.fetchCallingLists();
//       _selected ??= _lists.isNotEmpty ? _lists.first : null;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> refresh() => load();
//
//   void select(CallingList list) {
//     _selected = list;
//     notifyListeners();
//     // TODO: tell dashboard to reload for this list
//   }
// }

import 'package:flutter/foundation.dart';
import '../data/settings_repository.dart';
import '../models/calling_list.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this._repo);
  final SettingsRepository _repo;

  List<CallingList> _lists = [];
  CallingList? _selected;
  bool _isLoading = false;
  String _userId = '';

  List<CallingList> get lists => _lists;
  CallingList? get selected => _selected;
  bool get isLoading => _isLoading;

  Future<void> load(String userId) async {
    _userId = userId;
    _isLoading = true;
    notifyListeners();
    try {
      _lists = await _repo.fetchCallingLists(userId);
    } catch (_) {
      _lists = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() => load(_userId);

  void select(CallingList list) {
    _selected = list;
    notifyListeners();
  }
}
