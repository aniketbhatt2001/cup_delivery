import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:omniedeliveryapp/apiservice/api_service.dart';

import '../models/login_res_model.dart';
import '../utilities/constanst.dart';
import '../utilities/utils.dart';

class AuthService {
  static Future<LoginResModel?> signInUser(
      String email, String password) async {
    showLoadUp();
    final result = await ApiServices.postResponse(
        '$baseUrl/deliveryuser/login_check',
        {'device_type': 'MOB', 'username': email, 'password': password});
    pop();
    return result.fold((l) {
      showFailureBar(l.message);
    }, (r) {
      showsuccesBar(r.body['message']);
      final LoginResModel loginResModel =
          LoginResModel.fromJson(r.body as Map<String, dynamic>);
      return loginResModel;
    });
  }

  static sendOtp(String id, String mobile) async {
    final result = await ApiServices.postResponse('$baseUrl/otp/validate/1',
        {'device_type': 'MOB', 'mobile': mobile, 'user_id': id});

    return result.fold((l) => showFailureBar(l.message), (r) {
      showsuccesBar(r.body['message']);
    });
  }

  static Future<bool?> forgotPassword(
    String mobile,
  ) async {
    showLoadUp();
    final result = await ApiServices.postResponse(
        '$baseUrl/deliveryuser/forgot_password', {
      'device_type': 'MOB',
      'mobile': mobile,
    });

    pop();
    return result.fold((l) {
      showFailureBar(l.message);
    }, (r) {
      print(r.body);
      showsuccesBar(r.body['message']);
      return true;
    });
  }

  static Future<bool?> resetPassword(
      String mobile, String otp, String password, String cPassword) async {
    showLoadUp();
    final result =
        await ApiServices.postResponse('$baseUrl/deliveryuser/reset_password', {
      'device_type': 'MOB',
      'mobile': mobile,
      'otp': otp,
      'password': password,
      'confirm_password': cPassword
    });
    print({
      'device_type': 'MOB',
      'mobile': mobile,
      'otp': otp,
      'password': password,
      'confirm_password': cPassword
    });
    pop();
    return result.fold((l) {
      showFailureBar(l.message);
    }, (r) {
      print(r.body);
      showsuccesBar(r.body['message']);
      return true;
    });
  }
}
