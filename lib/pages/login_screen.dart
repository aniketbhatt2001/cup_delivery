import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:omniedeliveryapp/apiservice/auth_service.dart';
import 'package:omniedeliveryapp/apiservice/notification_services.dart';
import 'package:omniedeliveryapp/apiservice/user_services.dart';
import 'package:omniedeliveryapp/pages/forgot_password.dart';
import 'package:omniedeliveryapp/pages/main_screen.dart';
import 'package:omniedeliveryapp/pages/notification.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';
import 'package:omniedeliveryapp/utilities/constanst.dart';
import 'package:omniedeliveryapp/utilities/utils.dart';

import 'current_orders.dart';

GetStorage box = GetStorage();

class Login extends ConsumerStatefulWidget {
  Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final GlobalKey<FormState> formState = GlobalKey();

  final TextEditingController emailClr = TextEditingController();

  final TextEditingController passClr = TextEditingController();

  //final height = MediaQuery.of(context).
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return Scaffold(
          backgroundColor: primary,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              // physics: bouncingScrollPhysics,
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6,
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          MediaQuery.of(context).padding.bottom),
                  //height: p1.maxHeight / 2.5,
                  width: p1.maxWidth,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Form(
                      key: formState,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const ListTile(
                            title: Text('Login',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            width: p1.maxWidth,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            height: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: TextFormField(
                                  controller: emailClr,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Username';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            width: p1.maxWidth,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            height: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: TextFormField(
                                  controller: passClr,
                                  obscureText: isHidden,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter password';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHidden = !isHidden;
                                      });
                                    },
                                    icon: Icon(
                                      isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(ForgotPassword());
                                },
                                child: const Text('Forgot password ?')),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (formState.currentState!.validate()) {
                                UserServices.signinUser(
                                        emailClr.text, passClr.text, ref)
                                    .then((value) {
                                  UserServices.updateUserAppInfo(
                                      ref.read(userprovider).deliveryUserId!,
                                      fcmToken!);
                                });

                                // NotificationService.fetchNotification(
                                //         ref.read(userprovider).deliveryUserId!)
                                //     .then((value) {
                                //   print(value);
                                //   if (value != null) {
                                //     ref
                                //         .read(
                                //             notificationStateProvider.notifier)
                                //         .setState(value);
                                //     Get.offAll(const MainScreen());
                                //   }
                                // });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              width: p1.maxWidth,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
