import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/constanst.dart';
import '../utilities/utils.dart';
import '../widgets/app_bar_icons.dart';
import 'dialog_list.dart';
import 'login_screen.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userprovider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('My Profile'),
        actions: const [
          NotificationBell(),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.redAccent.shade200, primary],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          return const CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.person),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.fname!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                user.lname!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          user.username!.isNotEmpty
                              ? Text(
                                  user.username!,
                                  style: const TextStyle(color: Colors.white60),
                                )
                              : const SizedBox(),
                       
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                // ListTile(
                //   leading: Icon(Icons.history),
                // )
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final userConfig =
                  ref.read(userprovider.notifier).userAppConfigModel;
              final menu = userConfig.response![0].sidebarMenu![index];
              return menu.show == '1'
                  ? Column(
                      children: [
                        ListTile(
                          onTap: () {
                            launchMyURL(menu.link!);
                          },
                          // contentPadding: EdgeInsets.all(0),
                          leading: const Icon(
                            FontAwesomeIcons.globe,
                            color: Colors.black,
                          ),
                          title: Text(
                            menu.title!,
                            style: const TextStyle(color: Colors.black),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const Divider()
                      ],
                    )
                  : const SizedBox();
            },
            itemCount: ref
                .read(userprovider.notifier)
                .userAppConfigModel
                .response![0]
                .sidebarMenu!
                .length!,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox();
            },
          ),
          ListTile(
            onTap: () {
              showQuestion(
                  context, 'Logout', 'Are you sure you want to logout ?',
                  () async {
                await box.erase();

                Get.offAll(Login());
              }).show();
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return showQuestion(context);
              //   },
              // );
            },
            // contentPadding: EdgeInsets.all(0),
            leading: const Icon(
              Icons.power_settings_new_outlined,
              size: 19,
              color: Colors.black,
            ),
            title: const Text(
              'Log out',
              style: TextStyle(color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
