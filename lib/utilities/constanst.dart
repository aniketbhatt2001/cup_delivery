import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';

const baseUrl = 'https://www.chooseurprice.in/api_';
const yes = 'YES';
const no = 'NO';
String? fcmToken;

const String veg = 'Veg';
const String nonVeg = 'Non-veg';
const String eggetarian = 'Eggetarian';
const mapKey = 'AIzaSyC29GQ5OcOtLY6_ccSoUoXy3_HwhApkgGc';

const headers = {
  'Authorization': '\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0',
  'Client-Service': 'frontend-client-cup',
  'Auth-Key': 'simplerestapi_cup',
  'User-ID': '1',
  'Content-Type': 'application/x-www-form-urlencoded'
};
var bouncingScrollPhysics =
    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
final primary = HexColor('#cf0505');
final primaryAccent = HexColor('#e61313');
const tabs = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
  BottomNavigationBarItem(icon: Icon(Icons.category), label: "catehories"),
  BottomNavigationBarItem(icon: Icon(Icons.history), label: "my orders"),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile")
];
const radial = RadialGradient(
  colors: [Color(0xffdf1b0c), Color(0xfff55145)],
  stops: [1, 0],
  center: Alignment.center,
);
