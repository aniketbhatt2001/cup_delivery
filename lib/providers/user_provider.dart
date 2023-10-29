import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omniedeliveryapp/models/login_res_model.dart';
import 'package:omniedeliveryapp/states/user_state.dart';

final userprovider = StateNotifierProvider<UserStateNotifier, UserModel>(
    (ref) => UserStateNotifier(UserModel()));
