import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:omniedeliveryapp/apiservice/auth_service.dart';
import 'package:omniedeliveryapp/pages/otp_page.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';
import 'package:omniedeliveryapp/utilities/constanst.dart';

class ForgotPassword extends ConsumerWidget {
  final GlobalKey<FormState> formState = GlobalKey();
  final mobileClr = TextEditingController();
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (p0, p1) => Scaffold(
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 4,
                horizontal: 10),
            child: Card(
              // margin: EdgeInsets.symmetric(
              //     vertical: MediaQuery.of(context).size.height / 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: formState,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const ListTile(
                      title: Text('Forgot Password',
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
                            Icons.phone,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: mobileClr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter mobile no';
                              }
                              ref
                                  .read(userprovider.notifier)
                                  .updateMobile(value.toString());
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mobile no",
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

                    GestureDetector(
                      onTap: () async {
                        if (formState.currentState!.validate()) {
                          //  _createUser();
                          AuthService.forgotPassword(mobileClr.text)
                              .then((value) {
                            if (value != null) {
                              Get.offAll(const OtpPage());
                            }
                          });

                          //                                Get.offAll(const CurrentOrders());
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        width: p1.maxWidth,
                        height: 50,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          'SEND OTP',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       'Dont\'t have an account ?',
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.grey),
                    //     ),
                    //     TextButton(
                    //         onPressed: () {
                    //           Get.to(SignUp());
                    //         },
                    //         child: Text(
                    //           'Sign Up',
                    //           style: TextStyle(color: primary),
                    //         ))
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
