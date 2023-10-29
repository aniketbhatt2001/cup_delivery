// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:omniedeliveryapp/pages/order_detail.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';

import 'package:path_provider/path_provider.dart';
import 'package:overlay_support/overlay_support.dart';

import '../models/notification_model.dart';
import '../pages/notification.dart';
import '../utilities/constanst.dart';
import '../utilities/utils.dart';
import 'api_service.dart';

//
class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static void inItLocalNotification(
      BuildContext context, String userId, WidgetRef ref) async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    // IOSInitializationSettings iosInitializationSettings = const IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        //iOS: iosInitializationSettings
        iOS: const DarwinInitializationSettings());

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final data = details.payload;

        final open_page = jsonDecode(data!)['open_page'];
        final open_id = jsonDecode(data!)['open_id'];
        print(open_id);
        if (open_page != null && open_page.isNotEmpty) {
          switch (open_page) {
            case 'order_detail':
              Get.to(OrderDetail(orderNo: open_id));
          }
        }
      },
    );

    FirebaseMessaging.onMessage.listen((event) {
      showNotification(event, context, userId);
      NotificationService.fetchNotification(
              ref.read(userprovider).deliveryUserId!)
          .then((value) async {
        if (value != null) {
          // await Future.delayed(Duration(seconds: 3));
          ref.read(notificationStateProvider.notifier).setCount(value.count!);
        }
      });
    });
  }

  static Future<void> showNotification(
      RemoteMessage message, BuildContext context, String userId) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'my_channel_id',
      "high importance channel",
      importance: Importance.max,
    );
    final imageUrl = message.data['image'];
    if (imageUrl != null) {
      final largeIconPath = await downloadAndSaveImage(imageUrl, 'largeIcon');

      final BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(FilePathAndroidBitmap(largeIconPath),
              largeIcon: FilePathAndroidBitmap(largeIconPath),
              contentTitle: message.notification!.title,
              summaryText: message.notification!.body);

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(channel.id, channel.name,
              importance: Importance.max,
              priority: Priority.high,
              styleInformation: bigPictureStyleInformation);

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails);
    } else {
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        channel.id,
        channel.name,
        importance: Importance.max,
        priority: Priority.high,
      );

      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: jsonEncode(message.data));
    }
  }

  static Future<bool> requestNotification() async {
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
      // TODO: handle the received notificationselse {
    } else {
      print('User declined or has not accepted permission');

      return false;
    }
  }

// static void fireBaseInIt(){

//   FirebaseMessaging.onMessage.listen((event) {
//     log("new message while app in  foreground ");
//     log(event.notification!.body!);
//    // showSimpleNotification(Text(event.notification!.body!));
//     //inItLocalNotification(event);
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       log("mesaage opened");

//   });

// }

  static Future<NotificationModel?> fetchNotification(
    String userId,
  ) async {
    final response = await ApiServices.getResponse(
        '$baseUrl/deliveryuser/all_notification/MOB/delivery_user/$userId');

    return response.fold((l) {
      showFailureBar(l.message);
      return null;
    }, (r) {
      NotificationModel notificationModel =
          NotificationModel.fromJson(r.body as Map<String, dynamic>);

      return notificationModel;
    });
  }
}

Future<String> downloadAndSaveImage(String url, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName';
  final response = await http.get(Uri.parse(url));
  final file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}
