import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:omniedeliveryapp/apiservice/api_service.dart';
import 'package:omniedeliveryapp/models/delivery_model_res_model.dart';
import 'package:package_info/package_info.dart';
import 'package:geolocator/geolocator.dart';
import '../models/order_detail_model.dart';
import '../pages/current_orders.dart';
import '../pages/login_screen.dart';
import '../pages/main_screen.dart';
import '../pages/notification.dart';
import '../providers/user_provider.dart';
import '../utilities/constanst.dart';
import '../utilities/utils.dart';
import 'auth_service.dart';
import 'notification_services.dart';

class UserServices {
  static Future<bool> updateUserAppInfo(String userId, String fcmToken) async {
    late PackageInfo packageInfo;
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      var deviceUniqueId = "";
      var model = "";
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceUniqueId = androidInfo.androidId;
        model = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        deviceUniqueId = iosInfo.identifierForVendor;
        model = iosInfo.utsname.machine;
      }
      packageInfo = await PackageInfo.fromPlatform();

      http.Response response = await http.post(
          Uri.parse('$baseUrl/deliveryuser/delivery_update_app_info'),
          headers: headers,
          body: {
            'delivery_user_id': userId,
            "device_type": "MOB",
            'device_id': fcmToken,
            'device_unique_id': deviceUniqueId,
            'os_info': Platform.isIOS ? "ios" : "android",
            'model_name': model,
            'app_version': packageInfo.version,
            'more_app_info': DateTime.now().toString()
          });

      print({
        'delivery_user_id': userId,
        "device_type": "MOB",
        'device_id': fcmToken,
        'device_unique_id': deviceUniqueId,
        'os_info': Platform.isIOS ? "ios" : "android",
        'model_name': model,
        'app_version': packageInfo.version,
        'more_app_info': DateTime.now().toString()
      }.toString());
      if (response.statusCode == 200) {
        log('succesful');
        return true;
      } else {
        Map map = jsonDecode(response.body);
        String message = map['message'];
        showFailureBar(message);
        return false;
      }
    } catch (e) {
      showFailureBar(e.toString());
      return false;
    }
  }

  static Future<bool> updateDeliveryLocation(
    String userId,
  ) async {
    try {
      final pos = await Geolocator.getCurrentPosition();
      http.Response response = await http.post(
          Uri.parse('$baseUrl/deliveryuser/delivery_user_location'),
          headers: headers,
          body: {
            'delivery_user_id': userId,
            "device_type": "MOB",
            'delivery_user_latitudes': pos.latitude.toString(),
            'delivery_user_longitude': pos.longitude.toString(),
          });
      print({
        'delivery_user_id': userId,
        "device_type": "MOB",
        'delivery_user_latitudes': pos.latitude.toString(),
        'delivery_user_longitude': pos.longitude.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        log('succesful');
        return true;
      } else {
        Map map = jsonDecode(response.body);
        String message = map['message'];
        print(message);
        // showFailureBar(message);
        return false;
      }
    } catch (e) {
      print(e.toString());
      //showFailureBar(e.toString());
      return false;
    }
  }

  static Future<bool> orderPickUp(String userId, String orderNo) async {
    try {
      showLoadUp();

      http.Response response = await http.post(
          Uri.parse('$baseUrl/deliveryuser/delivery_user_order_pickup'),
          headers: headers,
          body: {
            'delivery_user_id': userId,
            "device_type": "MOB",
            'order_no': orderNo,
          });
      print({
        'delivery_user_id': userId,
        "device_type": "MOB",
        'order_no': orderNo,
      });
      pop();
      if (response.statusCode == 200) {
        log('succesful');
        return true;
      } else {
        print('inside orderPickUp');
        Map map = jsonDecode(response.body);
        String message = map['message'];
        showFailureBar(message);
        return false;
      }
    } catch (e) {
      showFailureBar(e.toString());
      return false;
    }
  }

  static Future<bool> userInTransit(
      String userId, String orderNo, String expected_date_time) async {
    try {
      showLoadUp();

      http.Response response = await http.post(
          Uri.parse('$baseUrl/deliveryuser/delivery_user_in_transit'),
          headers: headers,
          body: {
            'delivery_user_id': userId,
            "device_type": "MOB",
            'order_no': orderNo,
            'expected_date_time': ''
          });
      print({
        'delivery_user_id': userId,
        "device_type": "MOB",
        'order_no': orderNo,
        'expected_date_time': ''
      });
      pop();
      if (response.statusCode == 200) {
        log('succesful');
        return true;
      } else {
        Map map = jsonDecode(response.body);
        String message = map['message'];
        showFailureBar(message);
        return false;
      }
    } catch (e) {
      showFailureBar(e.toString());
      return false;
    }
  }

  static Future<bool> outForDelivery(
      String userId, String orderNo, String delivery_date_time) async {
    try {
      showLoadUp();

      http.Response response = await http.post(
          Uri.parse('$baseUrl/deliveryuser/delivery_user_out_of_delivery'),
          headers: headers,
          body: {
            'delivery_user_id': userId,
            "device_type": "MOB",
            'order_no': orderNo,
            'delivery_date_time': ''
          });
      print({
        'delivery_user_id': userId,
        "device_type": "MOB",
        'order_no': orderNo,
        'delivery_date_time': ''
      });
      pop();
      if (response.statusCode == 200) {
        log('succesful');
        return true;
      } else {
        Map map = jsonDecode(response.body);
        String message = map['message'];
        showFailureBar(message);
        return false;
      }
    } catch (e) {
      showFailureBar(e.toString());
      return false;
    }
  }

  static Future<bool> delivered(
      String userId, String orderNo, String verify_code) async {
    try {
      showLoadUp();

      http.Response response = await http.post(
          Uri.parse('$baseUrl/deliveryuser//delivery_user_delivered'),
          headers: headers,
          body: {
            'delivery_user_id': userId,
            "device_type": "MOB",
            'order_no': orderNo,
            'verify_code': verify_code
          });
      print({
        'delivery_user_id': userId,
        "device_type": "MOB",
        'order_no': orderNo,
        'verify_code': verify_code
      });
      pop();
      if (response.statusCode == 200) {
        log('succesful');
        return true;
      } else {
        Map map = jsonDecode(response.body);
        String message = map['message'];
        showFailureBar(message);
        return false;
      }
    } catch (e) {
      showFailureBar(e.toString());
      return false;
    }
  }

  static Future<DeliveryOrdersModelRes?> fetchCurrentOrders(
    String userId,
  ) async {
    final result = await ApiServices.getResponse(
        '$baseUrl/deliveryuser/current_orders/MOB/$userId');
    return result.fold((l) => null, (r) {
      return DeliveryOrdersModelRes.fromJson(r.body as Map<String, dynamic>);
    });
  }

  static Future<OrderDetailModel?> fetchOrderDeatil(
      String userId, String orderNo) async {
    final result = await ApiServices.getResponse(
        '$baseUrl/deliveryuser/single_order_detail/MOB/$userId/$orderNo');
    return result.fold((l) => showFailureBar(l.message), (r) {
      return OrderDetailModel.fromJson(r.body as Map<String, dynamic>);
    });
  }

  static Future<bool> signinUser(
      String email, String password, WidgetRef ref) async {
    final result = await AuthService.signInUser(email, password);
    if (result != null) {
      ref.read(userprovider.notifier).setUserState(result.response[0]);
      await box.write('userId', result.response[0].deliveryUserId);
      await box.write('userName', email);
      await box.write('password', password);

      if (result.response[0].updateLocation == '1') {
        UserServices.updateDeliveryLocation(result.response[0].deliveryUserId!);

        // UserServices.updateUserAppInfo(result., fcmToken)
      }
      NotificationService.fetchNotification(
              ref.read(userprovider).deliveryUserId!)
          .then((value) {
        print(value);
        if (value != null) {
          ref.read(notificationStateProvider.notifier).setState(value);
          Get.offAll(const MainScreen());
        }
      });

      return T;
    }
    return F;
  }
}
