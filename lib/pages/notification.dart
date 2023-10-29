// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';

import '../apiservice/api_service.dart';
import '../apiservice/notification_services.dart';
import '../models/notification_model.dart';
import '../states/notification_state.dart';
import '../utilities/constanst.dart';
import '../utilities/utils.dart';
import '../widgets/loading_waves.dart';

final notificationStateProvider =
    StateNotifierProvider<NotificationStateNotifier, NotificationModel>(
        (ref) => NotificationStateNotifier(NotificationModel()));

final toogleNotificationProvider = StateProvider.autoDispose((ref) => false);

final notificationProvider =
    FutureProvider.autoDispose.family<NotificationModel?, String>((ref, id) {
  ref.watch(toogleNotificationProvider);
  return NotificationService.fetchNotification(
    ref.read(userprovider).deliveryUserId!,
  );
});

class NotificationScreen extends ConsumerStatefulWidget {
  String userId;
  NotificationScreen({super.key, required this.userId});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref
        .watch(notificationProvider(ref.watch(userprovider).deliveryUserId!));
    // WidgetsBinding.instance!
    //     .addPostFrameCallback((_) => ref.watch(notificationStateProvider));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0,
          title: Text(
            "Notifications",
          ),
        ),
        body: LayoutBuilder(
            builder: (p0, p1) => data.when(
                  data: (data) {
                    if (data == null) {
                      return Center(
                        child: Text(
                          'No Notifications Found',
                        ),
                      );
                    }

                    // });
                    return data!.response!.isEmpty
                        ? Center(
                            child: Text(
                              'No Notifications Found',
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: data!.count.toString() == '0'
                                        ? SizedBox()
                                        : Consumer(builder: (ctx, ref, _) {
                                            return TextButton(
                                              child: Text("Mark As Read"),
                                              onPressed: () {
                                                //setState(() {});
                                                showLoadUp();
                                                ApiServices.getResponse(
                                                        '$baseUrl/deliveryuser/notification_seen/MOB/delivery_user/${widget.userId}/0')
                                                    .then((value) {
                                                  pop();
                                                  value.fold((l) {
                                                    showFailureBar(l.message);
                                                  }, (r) {
                                                    // setState(() {
                                                    //   // notifierProvider
                                                    //   //     .resetNotificationCount();
                                                    // });
                                                    final status = ref.read(
                                                        toogleNotificationProvider);
                                                    ref
                                                        .read(
                                                            toogleNotificationProvider
                                                                .notifier)
                                                        .state = !status;
                                                    ref
                                                        .read(
                                                            notificationStateProvider
                                                                .notifier)
                                                        .resetNotificationCount();
                                                  });
                                                });
                                              },
                                            );
                                          }))

                                // : Container(
                                //     margin: EdgeInsets.symmetric(
                                //         vertical: p1.maxHeight / 2.5),
                                //     child: Align(
                                //       alignment: Alignment.center,
                                //       child: Text(
                                //         "No notifications available !! ",
                                //         style: boldtext,
                                //       ),
                                //     ),
                                //   ),
                                ,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: data!.response!.length,
                                      itemBuilder: (context, index) {
                                        return notificationItem(
                                          data!.response![index].isSeen!,
                                          data!.response![index].title!,
                                          data!.response![index].msg!,
                                          data!
                                              .response![index].notificationId!,
                                          data!.response![index].openPage!,
                                          data!.response![index].openId!,
                                          data!.response![index].img!,
                                          data!.response![index].datetime!,
                                          context,
                                          widget.userId,
                                          int.parse(data!.count.toString()),
                                          ref,
                                          data!.response![index].openSlug!,
                                        );
                                      }),
                                )
                                // : Container(
                                //     margin: EdgeInsets.symmetric(
                                //         vertical: p1.maxHeight / 2.5),
                                //     child: Align(
                                //       alignment: Alignment.center,
                                //       child: Text(
                                //         "No Notifications Found",
                                //         style: boldtext,
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                          );
                  },
                  error: (error, stackTrace) {
                    return Center(
                      child: Text(
                        error.toString(),
                      ),
                    );
                  },
                  loading: () {
                    return Center(
                      child: LoadingWaves(),
                    );
                  },
                )));
  }
}

Widget notificationItem(
    String seen,
    String title,
    String body,
    String id,
    String openpage,
    String openid,
    String img,
    String date,
    BuildContext context,
    String userId,
    int count,
    WidgetRef ref,
    String slug) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            img.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              content: Container(
                            width: double.infinity,
                            child: Image.network(
                              img,
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null)
                                  return child; // Image fully loaded, show it
                                return Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.red,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress!
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                                .toInt()
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ));
                        },
                      );
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Image.network(
                        img,
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          "assets/notificationbel.png",
                        ))),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  if (seen == '0') {
                    showLoadUp();
                    await ApiServices.getResponse(
                            '$baseUrl/deliveryuser/notification_seen/MOB/delivery_user/$userId/$id')
                        .then((value) {
                      pop();
                      value.fold((l) {
                        showFailureBar(l.message);
                      }, (r) {
                        // notificationProvider.decrementCount();
                        final status = ref.read(toogleNotificationProvider);
                        ref.read(toogleNotificationProvider.notifier).state =
                            !status;
                        ref
                            .read(notificationStateProvider.notifier)
                            .decrementCount();
                      });
                    });
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: seen == '0'
                          ? TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)
                          : TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    body.isEmpty
                        ? SizedBox()
                        : Text(
                            //maxLines: ref.watch(readmore) ? null : 2,
                            body,
                            style: seen == '0'
                                ? TextStyle(fontSize: 12.0)
                                : TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        date,
                        style: seen == '0'
                            ? TextStyle(fontSize: 12.0)
                            : TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ),
                    // hasTextOverflow(
                    //         body,
                    //         ref.watch(unseenbool)
                    //             ? TextStyle(fontSize: 14.0)
                    //             : TextStyle(
                    //                 fontSize: 14.0, color: Colors.grey),
                    //         2)
                    //     ? TextButton(
                    //         onPressed: () {
                    //           ref.read(readmore.notifier).state =
                    //               !ref.read(readmore.notifier).state;
                    //         },
                    //         child: ref.watch(readmore)
                    //             ? Text("Read Less")
                    //             : Text("Read More"))
                    //     : Container()
                  ],
                ),
              ),
            )
          ],
        )),
  );
}
