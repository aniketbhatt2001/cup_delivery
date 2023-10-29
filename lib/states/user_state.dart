import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:omniedeliveryapp/models/login_res_model.dart';

import '../models/userapp_config_model.dart';

class UserStateNotifier extends StateNotifier<UserModel> {
  UserStateNotifier(UserModel state) : super(state);

  late UserAppConfigModel userAppConfigModel;

  setUserAppConfigModel(UserAppConfigModel userAppConfigModel) {
    this.userAppConfigModel = userAppConfigModel;
  }

  late LatLng currentLatlng;
  String? otpSent;
  setOtp(String otp) {
    otpSent = otp;
  }

  updateFName(String fName) {
    state = state.copyWith(fname: fName);
  }

  updateLName(String lName) {
    state = state.copyWith(lname: lName);
  }

  updateMobile(String mobile) {
    state = state.copyWith(mobile: mobile);
  }

  setUserState(UserModel userModel) {
    state = userModel;
  }
}
