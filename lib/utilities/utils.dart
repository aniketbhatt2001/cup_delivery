import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/loading_waves.dart';

showsuccesBar(String title, [String? message]) {
  if (title.isEmpty) {
    return;
  }
  Get.snackbar(title, message ?? '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      messageText: SizedBox(),
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      colorText: Colors.white);
}

showFailureBar(String title, [String? message]) {
  if (title.isEmpty) {
    return;
  }
  Get.snackbar(title, message ?? '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      messageText: SizedBox(),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      colorText: Colors.white);
}

Color generateRandomColor({int opacity = 255}) {
  final Random random = Random();
  //255, 102, 102
  final int r = random.nextInt(255);
  final int g = random.nextInt(102);
  final int b = random.nextInt(102);
  return Color.fromARGB(opacity, r, g, b);
}

myLato({double? size, FontWeight? fontWeight, Color? color}) {
  return GoogleFonts.lato(
      textStyle:
          TextStyle(fontSize: size, fontWeight: fontWeight, color: color));
}

var timerGradient = const BoxDecoration(
    gradient: LinearGradient(
  colors: [Color(0x87ffeb3b), Color(0xe6f32e20)],
  stops: [0, 1],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
)

    //     gradient: LinearGradient(
    //   colors: [Color(0xdbffeb3b), Color(0xc2f44336)],
    //   stops: [0, 1],
    //   begin: Alignment.centerRight,
    //   end: Alignment.centerLeft,
    // )

    //     gradient: LinearGradient(
    //   begin: Alignment.topLeft,
    //   end: Alignment.bottomRight,
    //   // stops: [0.3, 0.6, 0.9],
    //   colors: GradientColors.leCocktail,
    // )
    );
void launchDialer(String phoneNumber, BuildContext context) async {
  Uri url = Uri(scheme: "tel", path: phoneNumber);
  // Uri phoneno = Uri.parse(snapshot.data!.phone!,);
  if (await launchUrl(url)) {
    //dialer opened
  } else {
    //dailer is not opened
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Please try Again')));
  }
}

void showLoadUp() {
  Get.dialog(const LoadingWaves());
}

pop([bool closeOverlays = false]) {
  Get.back(closeOverlays: closeOverlays);
}

void launchMyURL(String url) async {
  // const url = 'https://www.example.com';
  await launch(
    url,
  );
}
