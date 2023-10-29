import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:omniedeliveryapp/utilities/constanst.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/order_detail_model.dart';
import '../widgets/gradient_container.dart';

class LiveTrackerPage extends StatefulWidget {
  LatLng coordinates;
  LatLng destination;

  final OrderUserAddress data;

  LiveTrackerPage(this.coordinates, this.destination, this.data);

  @override
  State<LiveTrackerPage> createState() => _LiveTrackerPageState();
}

class _LiveTrackerPageState extends State<LiveTrackerPage> {
  late LatLng coordinates;
  late LatLng destination;
  late Marker startMarker;
  GoogleMapController? mapController;
  List<Marker> markersList = [];
  List<LatLng> polylineCoordinates = [];
  // late PolylinePoints polylinePoints;
  //Map<PolylineId, Polyline> polylines = {};
  late LatLng southwest;
  late LatLng northeast;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    coordinates = widget.coordinates;
    destination = widget.destination;
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final pos = await Geolocator.getCurrentPosition();
      // coordinates = LatLng(pos.latitude, pos.longitude);
      if (mounted) {
        setState(() {
          markersList.removeWhere((marker) => marker.markerId.value == "1");
          markersList.add(
            Marker(
              markerId: MarkerId("1"),
              position: LatLng(pos.latitude, pos.longitude),
              //coordinates,
              infoWindow: InfoWindow(
                title: 'You',
              ),
              icon: BitmapDescriptor.defaultMarker,
            ),
          );
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  void onMapCreated(controller) {
    print("created");
    mapController = controller;

    initMap();
  }

  Future initMap() async {
    startMarker = Marker(
      markerId: const MarkerId("1"),
      position: coordinates,
      infoWindow: const InfoWindow(
        title: 'You',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

// Destination Location Marker
    Marker destinationMarker = Marker(
      markerId: const MarkerId("2"),
      position: destination,
      infoWindow: const InfoWindow(
        title: 'User',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
    markersList.add(startMarker);
    markersList.add(destinationMarker);

    southwest = LatLng(
      min(coordinates.latitude, destination.latitude),
      min(coordinates.longitude, destination.longitude),
    );

    northeast = LatLng(
      max(coordinates.latitude, destination.latitude),
      max(coordinates.longitude, destination.longitude),
    );

    // await _createPolylines(coordinates.latitude, coordinates.longitude,
    //     destination.latitude, destination.longitude);

    await Future.delayed(const Duration(seconds: 0), () {
      mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: northeast,
            southwest: southwest,
          ),
          100.0,
        ),
      );
    });

    setState(() {});
  }

  // _createPolylines(
  //   double startLatitude,
  //   double startLongitude,
  //   double destinationLatitude,
  //   double destinationLongitude,
  // ) async {
  //   // Initializing PolylinePoints
  //   polylinePoints = PolylinePoints();

  //   // Generating the list of coordinates to be used for
  //   // drawing the polylines

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     mapKey, // Google Maps API Key
  //     PointLatLng(startLatitude, startLongitude),
  //     PointLatLng(destinationLatitude, destinationLongitude),
  //     travelMode: TravelMode.driving,
  //   );

  //   // Adding the coordinates to the list
  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     }
  //   }

  //   // Defining an ID
  //   PolylineId id = const PolylineId('poly');

  //   // Initializing Polyline
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Colors.blue,
  //     points: polylineCoordinates,
  //     width: 5,
  //   );

  //   // Adding the polyline to the map
  //   polylines[id] = polyline;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launchUrl(widget.data.mobile);
        },
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          gradientContainer(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50.0, bottom: 20.0, left: 18, right: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 45),
                          child: Text(
                            "Live Location",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ))),
          Expanded(
            child: GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(coordinates.latitude, coordinates.longitude),
                zoom: 17.0,
              ),
              markers: Set.from(markersList),
              polylines: {
                Polyline(
                    polylineId: PolylineId('polyline'),
                    points: [widget.coordinates, widget.destination],
                    color: Colors.blue,
                    width: 8,
                    startCap: Cap.roundCap)
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "User Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 20),
                      Text(widget.data.userName)
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 10),
                  //         child: Icon(Icons.timer)),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text("Reach Time"),
                  //         SizedBox(height: 5),
                  //         Text("${widget.data['away_time']}")
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 20),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                  //     child: Icon(Icons.location_pin)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Address :"),
                      const SizedBox(height: 10),
                      Text(
                        "${widget.data.address1}, ${widget.data.city}, ${widget.data.state}, ${widget.data.pincode}",
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse('tel:$url'),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
