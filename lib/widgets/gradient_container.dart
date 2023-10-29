import 'package:flutter/material.dart';
import 'package:omniedeliveryapp/utilities/constanst.dart';

Widget gradientContainer({double? height, double? width, Widget? child}) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.red,
          primary,
        ],
      )),
      child: Center(child: child));
}
