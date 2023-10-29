import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:omniedeliveryapp/models/order_detail_model.dart';
import 'package:omniedeliveryapp/pages/order_detail.dart';
import 'package:omniedeliveryapp/pages/profile.dart';
import 'package:omniedeliveryapp/pages/splash_screen.dart';
import 'package:omniedeliveryapp/providers/order_provider.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';
import 'package:omniedeliveryapp/utilities/constanst.dart';
import 'package:omniedeliveryapp/utilities/utils.dart';
import 'package:omniedeliveryapp/widgets/app_bar_icons.dart';
import 'package:omniedeliveryapp/widgets/loading_waves.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'main_screen.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({super.key});

  @override
  State<CurrentOrders> createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  List<Widget> screen = [Orders(), const Profile()];
  int cuurentIndex = 0;

  // String appBarTitle =
  @override
  Widget build(BuildContext context) {
    // box.erase();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        //  showUnselectedLabels: true,
        iconSize: 23,

        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        onTap: (value) {
          setState(() {
            cuurentIndex = value;
          });
          if (value == 1) {
            //Get.to(const AllCategories());
          } else if (value == 2) {
            // Get.to(MyOrders());
          } else if (value == 3) {
            //Get.to(const Profile());
          }
        },
        currentIndex: cuurentIndex,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey.shade700,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      backgroundColor: Colors.white,
      body: screen[cuurentIndex],
    );
  }
}

class Orders extends ConsumerWidget {
  final clr = RefreshController();
  //static const
  Orders({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Current Orders'),
        actions: const [
          NotificationBell(),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: orderData.when(
        data: (data) {
          if (data == null || data.response.isEmpty) {
            return SmartRefresher(
              onRefresh: () {
                final statsus = ref.read(ordersToggler);
                ref.read(ordersToggler.notifier).state = !statsus;
                clr.refreshCompleted();
              },
              controller: clr,
              child: Center(
                child: Text(
                  'No orders found !!',
                  style: myLato(fontWeight: FontWeight.bold, size: 17),
                ),
              ),
            );
          }
          return SmartRefresher(
            onRefresh: () {
              final statsus = ref.read(ordersToggler);
              ref.read(ordersToggler.notifier).state = !statsus;
              clr.refreshCompleted();
            },
            controller: clr,
            child: ListView.builder(
              //  padding: ,
              itemBuilder: (context, index) {
                final order = data.response[index];

                DateTime orderDateTime = DateTime.parse(order.orderDateTime);
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(orderDateTime);
                String formattedTime =
                    DateFormat('h:mm a').format(orderDateTime);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      trailing: Column(
                        children: [
                          Text(
                            '$formattedDate  $formattedTime',
                            style:
                                myLato(size: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 22,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    backgroundColor: HexColor(order.bgColor)),
                                onPressed: () {
                                  showModalBottomSheet(
                                    isDismissible: T,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => ChangeStatus(
                                      orderDetailModel:
                                          Order.fromJson(order.toJson()),
                                    ),
                                  );
                                },
                                child: Text(
                                  order.orderCompleted,
                                  style: myLato(
                                      size: 13,
                                      color: order.color != order.bgColor
                                          ? HexColor(order.color)
                                          : Colors.white),
                                )),
                          )
                        ],
                      ),
                      leading: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor(order.bgColor!)),
                        child: const Icon(
                          Icons.production_quantity_limits_outlined,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Get.off(() => OrderDetail(
                              orderNo: order.orderNo,
                            ));
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                order.orderNo,
                                style: myLato(size: 13, color: primary),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                'Total Amount',
                                style: myLato(
                                    size: 13, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₹${order.orderTotalAmount}',
                                    style: myLato(
                                        size: 13, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //Text(data),
                          const SizedBox(
                            height: 4,
                          ),
                          order.collectAmount.isNotEmpty
                              ? Row(
                                  children: [
                                    Text(
                                      'Collect Amount',
                                      style: myLato(
                                          size: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '₹${order.collectAmount}',
                                      style: myLato(
                                          size: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          // const SizedBox(
                          //   height: 8,
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: data!.response.length,
            ),
          );
        },
        error: (error, stackTrace) {
          print(stackTrace);
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const Center(
            child: LoadingWaves(),
          );
        },
      ),
    );
  }
}
