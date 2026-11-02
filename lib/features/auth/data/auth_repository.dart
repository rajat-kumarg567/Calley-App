import '../../../core/network/api_client.dart';
import '../models/user_model.dart';
import 'package:flutter/foundation.dart';



class AuthRepository {
  Future<UserModel> login({required String email, required String password}) async {
    final res = await ApiClient.instance.get('/userloginV3', query: {
      'emailid': email,
      'password': password,
    });
    debugPrint('LOGIN RESPONSE: $res');

    final Map data = res is Map ? res : {};
    if (data['StatusCode'].toString() != '1') {
      throw ApiException((data['Message'] ?? 'Invalid email or password').toString());
    }

    return UserModel(
      userId: data['userid'].toString(),
      name: (data['userName'] ?? '').toString(),
      email: email,
      phone: (data['userMobile'] ?? '').toString(),
      parentAccount: (data['parentAccount'] ?? 'NA').toString(),
      subscription: (data['userType'] ?? '').toString(),
    );
  }
  // Future<UserModel> login({required String email, required String password}) async {
  //   final res = await ApiClient.instance.get('/userloginV3', query: {
  //     'emailid': email,
  //     'password': password,
  //   });
  //   debugPrint('LOGIN RESPONSE: $res');
  //   return UserModel.dummy;
  // }



  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String countryCode,
    required String mobile,
  }) async {
    final res = await ApiClient.instance.get('/RegistrationV5', query: {
      'name': name,
      'emailId': email,
      'password': password,
      'mobile': mobile,
      'countrycode': countryCode.replaceAll('+', ''),
      'countryname': 'India',
      'location': 'android',
    });
    debugPrint('REGISTER RESPONSE: $res');
  }

  Future<String> sendOtp({required String userId}) async {
    final res = await ApiClient.instance.get('/SendOTP', query: {
      'userid': userId,
      'Device': 'android',
    });
    debugPrint('SEND OTP RESPONSE: $res');
    final Map data = res is Map ? res : {};
    if (data['StatusCode'].toString() != '1' || data['OTP'] == null) {
      throw ApiException('Could not send OTP');
    }
    return data['OTP'].toString();
  }

  Future<void> verifyOtp({required String userId}) async {
    await ApiClient.instance.get('/UpdateUserVerifiedStatus', query: {
      'userid': userId,
      'userMobile': 'android',
    });
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
