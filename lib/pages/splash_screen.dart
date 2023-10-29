import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:omniedeliveryapp/apiservice/map_services.dart';
import 'package:omniedeliveryapp/apiservice/user_services.dart';
import 'package:omniedeliveryapp/models/userapp_config_model.dart';
import 'package:omniedeliveryapp/pages/current_orders.dart';
import 'package:omniedeliveryapp/pages/login_screen.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';
import 'package:omniedeliveryapp/utilities/utils.dart';

import '../apiservice/api_service.dart';
import '../utilities/constanst.dart';

GetStorage box = GetStorage();

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    getUserAppConfig(ref);
    // Future.delayed(Duration(seconds: 2), () async {
    //   Get.offAll(Login());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Image.asset(
          'assets/updated_splash_screen.png',
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> getUserAppConfig(WidgetRef ref) async {
    final response =
        await ApiServices.getResponse('$baseUrl//app/user_app_config/MOB');
    response.fold((l) {
      showFailureBar(l.message);
      return;
    }, (r) async {
      ref.read(userprovider.notifier).userAppConfigModel =
          UserAppConfigModel.fromJson(r.body as Map<String, dynamic>);
      final loggedIn = box.read('userId');
      final userName = box.read('userName');
      final password = box.read('password');

      final data = await getCurrentLocationData();
      if (data == false) {
        return;
      }
      if (loggedIn != null) {
        final result =
            await UserServices.updateUserAppInfo(loggedIn, fcmToken!);
        if (result) {
          // ref.read(userprovider.notifier).updateFName(fName);
          // ref.read(userprovider.notifier).updateLName(lName);
          UserServices.signinUser(
              userName, password, ref); // Get.offAll(const CurrentOrders());
        } else {
          Get.offAll(Login());
        }
      } else {
        Get.offAll(Login());
      }
    });
  }
}
