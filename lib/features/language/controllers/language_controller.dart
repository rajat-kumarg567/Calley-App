import 'package:flutter/foundation.dart';
import '../data/language_repository.dart';
import '../models/language_model.dart';

class LanguageController extends ChangeNotifier {
  LanguageController(this._repo) : languages = _repo.getLanguages();

  final LanguageRepository _repo;
  final List<LanguageModel> languages;
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  LanguageModel get selected => languages[_selectedIndex];

  void select(int index) {
    _selectedIndex = index;
    notifyListeners();
    // TODO: persist + apply locale
  }
}
