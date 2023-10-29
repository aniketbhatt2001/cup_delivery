import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/order_detail_model.dart';
import '../utilities/constanst.dart';
import '../utilities/utils.dart';
import '../widgets/delivery_tracker.dart';

class DeliveryTracker extends StatelessWidget {
  String show_track_data_show;

  List<ShowTrackData> trackData;

  String trackDataTitle;
  String orderId;
  String orderDate;
  DeliveryTracker(
      {super.key,
      required this.orderDate,
      required this.orderId,
      required this.show_track_data_show,
      required this.trackDataTitle,
      required this.trackData});

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    // List<ShowTrackData> list = widget.trackData;

    return Column(
      children: [
        show_track_data_show == '1'
            ? Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 22, bottom: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tracking',
                        style: myLato(
                            fontWeight: FontWeight.bold,
                            size: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Text(
                    trackDataTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary:
                                  primary, // Customize the active step icon color
                            ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        child: ListView.builder(
                          itemCount: trackData.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            String last = trackData.last.title!;
                            if (trackData[index].title == last) {
                              return trackingWidget(
                                  trackData[index].title!,
                                  trackData[index].body!,
                                  trackData[index].isActive!,
                                  0,
                                  1,
                                  '#cf0505',
                                  trackData[index].dateTime!);
                            } else {
                              return trackingWidget(
                                  trackData[index].title!,
                                  trackData[index].body!,
                                  trackData[index].isActive!,
                                  1,
                                  1,
                                  '#cf0505',
                                  trackData[index].dateTime!);
                            }
                          },
                        ),
                      ))
                ],
              )
            : SizedBox(),
      ],
    );
  }
}

Widget trackingWidget(String title, String body, String done, int index,
    int length, String color, String dateTime) {
  return index != length - 1
      ? IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done == "1" ? HexColor(color) : Colors.black12),
                    child: done == "1"
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 30),
                      width: 5,
                      decoration: BoxDecoration(
                          color:
                              done == "1" ? HexColor(color) : Colors.black12),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              body,
                            ),
                            Text(
                              dateTime,
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done == "1" ? HexColor(color) : Colors.black12),
              child: done == "1"
                  ? const Icon(
                      Icons.done,
                      color: Colors.white,
                    )
                  : Container(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      body,
                    )
                  ],
                ),
              ),
            )
          ],
        );
}
