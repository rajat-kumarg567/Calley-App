import 'package:flutter/foundation.dart';
import '../data/auth_repository.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._repo);
  final AuthRepository _repo;

  UserModel _user = UserModel.dummy;
  bool _isLoading = false;
  String? _error;
  String? _sentOtp;

  UserModel get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> login(String email, String password) => _run(() async {
    _user = await _repo.login(email: email, password: password);
  });

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String countryCode,
    required String mobile,
  }) =>
      _run(() => _repo.register(
        name: name,
        email: email,
        password: password,
        countryCode: countryCode,
        mobile: mobile,
      ));


  Future<bool> sendOtp() => _run(() async {
    _sentOtp = await _repo.sendOtp(userId: _user.userId);
  });

  Future<bool> resendOtp(String phone) => sendOtp();

  Future<bool> verifyOtp(String typedOtp) async {
    if (_sentOtp == null || typedOtp != _sentOtp) {
      _error = 'Invalid OTP';
      notifyListeners();
      return false;
    }
    return _run(() => _repo.verifyOtp(userId: _user.userId));
  }

  Future<void> logout() => _repo.logout();

  Future<bool> _run(Future<void> Function() action) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await action();
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
