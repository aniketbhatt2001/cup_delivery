// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:omniedeliveryapp/apiservice/map_services.dart';
import 'package:omniedeliveryapp/apiservice/user_services.dart';
import 'package:omniedeliveryapp/pages/current_orders.dart';
import 'package:omniedeliveryapp/pages/live_tracker_page.dart';
import 'package:omniedeliveryapp/providers/order_provider.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:omniedeliveryapp/providers/order_detail_provider.dart';
import 'package:omniedeliveryapp/utilities/constanst.dart';
import 'package:omniedeliveryapp/utilities/utils.dart';
import 'package:omniedeliveryapp/widgets/loading_waves.dart';

import '../models/order_detail_model.dart';
import '../widgets/app_bar_icons.dart';
import '../widgets/delivery_tracker.dart';
import 'dialog_list.dart';
import 'main_screen.dart';

class OrderDetail extends ConsumerWidget {
  List<Map<String, dynamic>> tableData = [];
  final String orderNo;
  OrderDetail({
    required this.orderNo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(orderDetailProvider(orderNo.toString()));
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          pop();
        } else {
          Get.offAll(MainScreen());
        }
        return F;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  pop();
                } else {
                  Get.offAll(MainScreen());
                }
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: NotificationBell(),
            ),
          ],
          backgroundColor: primary,
          elevation: 0,
          title: const Text('Order Detail'),
        ),
        body: orderData.when(
          data: (data) {
            if (data == null || data.response.isEmpty) {
              return Center(
                child: Text(
                  'No data Found !',
                  style: myLato(fontWeight: FontWeight.bold),
                ),
              );
            }
            OrderUserAddress orderUserAddress =
                data!.response[0].orderUserAddress[0];
            OrderVendorAddress vendorAdress =
                data.response[0].orderVendorAddress[0];
            tableData = [
              {'type': 'Items', 'name': data.response[0].item},
              {
                'type': 'Payment Method',
                'name': data.response[0].paymentMethod
              },
              {
                'type': 'Payment Source',
                'name': data.response[0].paymentSource
              },
              {
                'type': 'Order Total',
                'name': '₹${data.response[0].orderTotalAmount}'
              },
              {
                'type': 'Collect Amount',
                'name': '₹${data.response[0].collectAmount}'
              },
            ];
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isDismissible: T,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => ChangeStatus(
                              orderDetailModel: data.response[0],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text('Change Status'),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.25,
                  child: ListView(
                    shrinkWrap: T,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Order No',
                              style: myLato(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 9),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: HexColor(data.response[0].bgColor),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(1, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              ' ${data.response[0].orderCompleted}',
                              style: TextStyle(
                                  color: HexColor(data.response[0].color!)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.response[0].orderNo,
                              style: myLato(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Text(data.response[0].orderDateTime),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "Orders",
                      //     style: myLato(fontWeight: FontWeight.bold, size: 20),
                      //   ),
                      // ),
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Order Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            //height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DataTable(
                                  dividerThickness: 0,
                                  headingRowHeight: 0,
                                  columnSpacing:
                                      MediaQuery.of(context).size.width / 2.9,
                                  dataRowHeight: 30,
                                  // horizontalMargin: 25.0,
                                  //border: TableBorder.all(),
                                  columns: const [
                                    DataColumn(label: Text('')),
                                    DataColumn(label: Text('')),
                                  ],
                                  rows: tableData
                                      .map((data) => DataRow(
                                            cells: [
                                              DataCell(Text('${data['type']}')),
                                              DataCell(Text('${data['name']}')),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Products',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      ListView(
                        // itemCount: snapshot.data!.response![0].orderData![0]
                        //     .orderDetail!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: data.response[0].orderDetails
                            .map((e) => Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: ListTile(
                                    subtitle: Text(
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                        'Qty ${e.productQty}'),
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(e.productPrice,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    contentPadding: const EdgeInsets.all(8),
                                    title: Text(
                                      e.productName,
                                      maxLines: null,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        e.productImg,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),

                      DeliveryTracker(
                        trackDataTitle: data.response[0].showTrackDataTitle,
                        trackData: data.response[0].showTrackData,
                        orderDate: data.response[0].orderDateTime,
                        orderId: data.response[0].orderNo,
                        show_track_data_show:
                            data.response[0].showTrackDataShow,
                      ),

                      data.response[0].showTrackDataShow == '1'
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Html(
                                shrinkWrap: true,
                                data: data.response[0].showTrackDataHtml,
                                style: {
                                  "body": Style(
                                      padding: const HtmlPaddings(),
                                      margin: const Margins()),
                                },
                              ))
                          : const SizedBox(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'User Information',
                              style:
                                  myLato(fontWeight: FontWeight.bold, size: 20),
                            ),
                            data.response[0].userMapShow == '1'
                                ? ElevatedButton(
                                    onPressed: () async {
                                      showLoadUp();
                                      final result =
                                          await Geolocator.getCurrentPosition();
                                      pop();
                                      Get.to(LiveTrackerPage(
                                          LatLng(result.latitude,
                                              result.longitude),
                                          LatLng(
                                              double.parse(data
                                                  .response[0]
                                                  .orderUserAddress[0]
                                                  .latitudes),
                                              double.parse(data
                                                  .response[0]
                                                  .orderUserAddress[0]
                                                  .longitude)),
                                          data.response[0]
                                              .orderUserAddress[0]));
                                    },
                                    child: const Text(' Track Live Location'))
                                : SizedBox()
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        // height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderUserAddress.userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              orderUserAddress.mobile.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        launchDialer(
                                            orderUserAddress.mobile, context);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            orderUserAddress.mobile,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${orderUserAddress.address1},  ${orderUserAddress.city}, ${orderUserAddress.pincode}',
                                maxLines: null,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Store Information',
                          style: myLato(fontWeight: FontWeight.bold, size: 20),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        // height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vendorAdress.companyName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              vendorAdress.mobile.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        launchDialer(
                                            vendorAdress.mobile, context);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            vendorAdress.mobile,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${vendorAdress.address},  ${vendorAdress.city}, ${vendorAdress.pincode}',
                                maxLines: null,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(
            child: LoadingWaves(),
          ),
        ),
      ),
    );
  }
}

class ChangeStatus extends StatelessWidget {
  final Order orderDetailModel;
  const ChangeStatus({
    Key? key,
    required this.orderDetailModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = orderDetailModel;
    return Consumer(builder: (context, ref, _) {
      final toggle = ref.read(toggleOrderDetailProvider);
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              color: primary,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Change Status',
                    style: myLato(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        pop();
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: T,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (data.showOrderPickupBtn == '1') {
                        showQuestion(context, "Confirmation",
                            'Are you sure you want to change status to Pickup Order ?',
                            () async {
                          final result = await UserServices.orderPickUp(
                              ref.read(userprovider).deliveryUserId!,
                              data.orderNo);
                          if (result) {
                            UserServices.updateDeliveryLocation(
                                ref.read(userprovider).deliveryUserId!);
                            ref.read(toggleOrderDetailProvider.notifier).state =
                                !toggle;
                            Get.back(closeOverlays: T);
                            final ordersStatus = ref.read(ordersToggler);

                            ref.read(ordersToggler.notifier).state =
                                !ordersStatus;
                          }
                        }).show();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Text('Order Pickup',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: data.showOrderPickupBtn == '1'
                                  ? Colors.black
                                  : Colors.grey)),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () async {
                      if (data.showOrderInTransitBtn == '1') {
                        showQuestion(context, "Confirmation",
                            'Are you sure you want to change status to In Transit ?',
                            () async {
                          final toggle = ref.read(toggleOrderDetailProvider);
                          final result = await UserServices.userInTransit(
                              ref.read(userprovider).deliveryUserId!,
                              orderDetailModel.orderNo,
                              '');
                          if (result) {
                            ref.read(toggleOrderDetailProvider.notifier).state =
                                !toggle;
                            print(ref.read(toggleOrderDetailProvider));
                            Get.back(closeOverlays: T);
                            final ordersStatus = ref.read(ordersToggler);

                            ref.read(ordersToggler.notifier).state =
                                !ordersStatus;
                            UserServices.updateDeliveryLocation(
                                ref.read(userprovider).deliveryUserId!);
                          }
                          // showTransitDialog(context, ref, orderDetailModel);
                        }).show();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Text(
                        'In Transit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: data.showOrderInTransitBtn == '1'
                                ? Colors.black
                                : Colors.grey),
                      ),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () async {
                      if (data.showOutOfDeliveryBtn == '1') {
                        showQuestion(context, 'Confirmation ',
                            'Are you sure you want to change status to Out For Delivery ',
                            () async {
                          final result = await UserServices.outForDelivery(
                              ref.read(userprovider).deliveryUserId!,
                              orderDetailModel.orderNo,
                              '');
                          if (result) {
                            final toggle = ref.read(toggleOrderDetailProvider);
                            ref.read(toggleOrderDetailProvider.notifier).state =
                                !toggle;
                            final ordersStatus = ref.read(ordersToggler);

                            ref.read(ordersToggler.notifier).state =
                                !ordersStatus;
                            Get.back(closeOverlays: T);
                            UserServices.updateDeliveryLocation(
                                ref.read(userprovider).deliveryUserId!);
                          }
                        }).show();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Text(
                        'Out for Delivery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: data.showOutOfDeliveryBtn == '1'
                                ? Colors.black
                                : Colors.grey),
                      ),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      showQuestion(context, 'Confirmation',
                          'Are you sure you want to change status to Delivered ? ',
                          () {
                        final ordersStatus = ref.read(ordersToggler);

                        ref.read(ordersToggler.notifier).state = !ordersStatus;
                        showDeliveredDialog(context, ref, orderDetailModel);
                      }).show();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Text(
                        'Delivered',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: data.showDeliveredBtn == '1'
                                ? Colors.black
                                : Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  void showDeliveredDialog(
      BuildContext context, WidgetRef ref, Order orderDetailModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final codeClr = TextEditingController();
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                // Do something when the "Cancel" button is pressed
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                pop();
                // Do something when the "OK" button is pressed
                UserServices.updateDeliveryLocation(
                    ref.read(userprovider).deliveryUserId!);

                final result = await UserServices.delivered(
                    ref.read(userprovider).deliveryUserId!,
                    orderDetailModel.orderNo,
                    codeClr.text);
                if (result) {
                  ref.invalidate(ordersProvider);

                  Get.offAll(const MainScreen());
                }
              },
              child: const Text('OK'),
            ),
          ],
          title: const Text('Verification Code'),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: codeClr,
            decoration:
                const InputDecoration(hintText: 'Enter verification code'),
          ),
        );
      },
    );
  }
}
