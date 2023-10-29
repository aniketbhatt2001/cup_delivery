// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:omniedeliveryapp/pages/current_orders.dart';
import 'package:omniedeliveryapp/pages/login_screen.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../apiservice/auth_service.dart';
import '../utilities/constanst.dart';
import '../utilities/utils.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  bool resendOtpClicked = false;
  bool hasError = false;
  String currentText = "";
  TextEditingController pinCodeClr = TextEditingController();
  TextEditingController mobileClr = TextEditingController();
  TextEditingController passClr = TextEditingController();
  TextEditingController conFirmPassClr = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> passFormkey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> mobileFormKey = GlobalKey<FormFieldState>();
  int _counter = 59;
  Timer? _timer;
  String resendOtp = "Resend Again";
  bool isHidden = true;
  bool isCPassHidden = true;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        debugPrint("Countdown started");
        if (_counter > 0) {
          _counter--;
          debugPrint("$_counter");
        } else {
          _timer!.cancel();
          resendOtpClicked = !resendOtpClicked;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
    // basicDetailProvider = Provider.of(context, listen: false);
    // ApiSerices.postResponse('$baseUrl/otp/validate/1', {
    //   'device_type': 'MOB',
    //   'mobile': basicDetailProvider.userModel!.mobile!,
    //   'user_id': basicDetailProvider.userModel!.userId,
    // }).then((value) {
    //   value.fold((l) {
    //     show_Icon_Flushbar(context, l.message, warning);
    //   }, (r) {
    //     Map userMap = r.body;
    //     List list = userMap['response'];
    //     basicDetailProvider.otp = list[0]['otp'];
    //     show_sucess_flushbar(context, 'otp sent successfully', done);
    //   });
    // });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) => Scaffold(
        backgroundColor: Colors.grey.shade100,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: primary,
          title: const Text('Verification Code'),
        ),
        // backgroundColor: primaryColor,
        body: SizedBox(
          child: Builder(builder: (scaffoldContxet) {
            return ListView(
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  'We have sent the verification code to the',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'registered mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        ref.watch(userprovider.select((value) => value.mobile));
                        return Text(
                          ref.read(userprovider).mobile!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400),
                        );
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Update Phone Number",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    //    popCurrent(context);
                                                    pop();
                                                  },
                                                  icon: const Icon(
                                                      FontAwesomeIcons
                                                          .xmarkCircle))
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 0),
                                          child: Text(
                                            "This new phone number has to be verified for that an otp will be sent to new phone number",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: TextFormField(
                                            key: mobileFormKey,
                                            controller: mobileClr,
                                            onChanged: (value) {
                                              // basicDetailProvider.userModel
                                              //     .mobile = value.trim();
                                              ref
                                                  .read(userprovider.notifier)
                                                  .updateMobile(value);
                                            },
                                            validator: (value) {
                                              String val = value!.trim();
                                              if (val!.isEmpty) {
                                                return 'Enter Mobile number';
                                              } else {
                                                // basicDetailProvider
                                                //     .userModel!.state = val;
                                                return null;
                                              }
                                            },
                                            //controller: editcontroller,
                                            keyboardType: TextInputType.name,
                                            style:
                                                const TextStyle(fontSize: 14.0),

                                            decoration: InputDecoration(
                                              hintText: 'Mobile no.',
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (mobileFormKey.currentState!
                                                  .validate()) {
                                                pop();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: primary),
                                            child: const Text("Update"),
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 18,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formkey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,

                        // obscuringWidget: const FlutterLogo(
                        //   size: 24,
                        // ),
                        blinkWhenObscuring: true,
                        //animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 4) {
                            return '';
                            //hasError = true;
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.white,
                          activeColor: Colors.white,
                          selectedFillColor: Colors.white,
                          selectedColor: Colors.white,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,

                        controller: pinCodeClr,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black12,
                            blurRadius: 20,
                          )
                        ],
                        onCompleted: (v) {},
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          currentText = value;
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError == true
                        ? "Please fill up all the cells properly"
                        : "",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: passFormkey,
                    child: Column(
                      children: [
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
                                controller: conFirmPassClr,
                                obscureText: isCPassHidden,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter password';
                                  }
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isCPassHidden = !isCPassHidden;
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
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 110),
                  decoration: BoxDecoration(
                    color: HexColor('#ED1C24'),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ButtonTheme(
                    child: TextButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          if (passFormkey.currentState!.validate()) {
                            print(ref.read(userprovider).mobile!);
                            AuthService.resetPassword(
                                    ref.read(userprovider).mobile!,
                                    pinCodeClr.text,
                                    passClr.text,
                                    conFirmPassClr.text)
                                .then((value) {
                              if (value != null) {
                                Get.offAll(Login());
                              }
                            });
                          } else {
                            showFailureBar('Enter Password');
                          }
                        } else {
                          showFailureBar('Enter Otp');
                        }

                        //ApiSerices.postResponse('$baseUrl/', body)
                        // conditions for validating
                      },
                      child: const Center(
                          child: Text(
                        "Verify",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                resendOtpClicked
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Didn\'t receive the OTP?"),
                            TextButton(
                                onPressed: () async {
                                  _counter = 59;
                                  resendOtpClicked = !resendOtpClicked;

                                  _startTimer();
                                  AuthService.forgotPassword(
                                          ref.read(userprovider).mobile!)
                                      .then((value) {});
                                  // ApiSerices.postResponse(
                                  //     '$baseUrl/otp/validate/1', {
                                  //   'device_type': 'MOB',
                                  //   'mobile':
                                  //       basicDetailProvider.userModel!.mobile!,
                                  //   'user_id':
                                  //       basicDetailProvider.userModel!.userId,
                                  // }).then((value) {
                                  //   value.fold((l) {
                                  //     print('error${l.message}');
                                  //     show_Icon_Flushbar(
                                  //         context, l.message, warning);
                                  //   }, (r) {
                                  //     Map userMap = r.body;
                                  //     List list = userMap['response'];
                                  //     basicDetailProvider.otp = list[0]['otp'];
                                  //     show_sucess_flushbar(context,
                                  //         'otp sent successfully', done);
                                  //   });
                                  // });
                                },
                                child: Text(
                                  resendOtp,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " Resend Again ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("00:${_counter.toString().padLeft(2, '0')}")
                          ],
                        ),
                      )
                // TextButton(
                //   onPressed: () {
                //     ApiSerices.postResponse('$baseUrl/otp/validate/1', {
                //       'device_type': 'MOB',
                //       'mobile': basicDetailProvider.userModel!.mobile,
                //       'user_id': basicDetailProvider.userModel!.userId,
                //     }).then((value) {
                //       print('inside response');
                //       value.fold((l) {
                //         print('error${l.message}');
                //         show_Icon_Flushbar(context, l.message, warning);
                //       }, (r) {
                //         print(r.body);
                //         Map userMap = r.body;
                //         List list = userMap['response'];
                //         basicDetailProvider.otp = list[0]['otp'];
                //         show_Icon_Flushbar(context, 'otp sent successfully',
                //             const Icon(Icons.thumb_up));
                //       });
                //     });
                //   },
                //   child: const Text(
                //     "Resend OTP",
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 16,
                //         color: Colors.black54),
                //   ),
                // ),
                ,
                const SizedBox(
                  height: 14,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  _valiadte_user(String id, String mobile, String otp, String password,
      String cPass) async {
    // showLoadUp();
    // final result = await ApiServices.postResponse('$baseUrl/otp/validate/0',
    //     {'device_type': 'MOB', 'user_id': id, 'mobile': mobile, 'otp': otp});

    // pop();
    // result.fold((l) {
    //   showFailureBar(l.message);
    // }, (r) async {
    //   box.write('userId', id);
    //   showsuccesBar(r.body['message']);
    //   final showRegisterScreen = r.body['response'][0]['show_register_screen'];
    //   //Get.offAll(const CurrentOrders());
    //   if (showRegisterScreen != null && showRegisterScreen == '1') {
    //     Get.offAll(SignUp());
    //   } else {
    //     showLoadUp();
    //     final user = await UserServices.getUserDetails(id);
    //     pop();
    //     if (user != null) {
    //       ref.read(userStateProvider.notifier).createState(user);

    //       Get.offAll(const CurrentOrders());
    //     }
    //   }
    // });
  }
}
