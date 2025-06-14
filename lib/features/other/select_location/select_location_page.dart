import 'dart:async';
import 'package:garage/core/ui/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:garage/utils/utlis.dart';
import 'select_location_controller.dart';

class SelectLocationPage extends StatefulWidget {
  SelectLocationPage() {}

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  final controller = Get.find<SelectLocationController>();
  final state = Get.find<SelectLocationController>().state;

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _currentLatLng = CameraPosition(
    target: LatLng(29.3759, 47.9774),
    zoom: 20,
  );

  LatLng? _centerLocation;

  @override
  void initState() {
    if (Get.arguments != null &&
        Get.arguments["lat"] != null &&
        Get.arguments["lat"] != "0.0" &&
        Get.arguments["lat"] != "") {
      _currentLatLng = CameraPosition(
        target: LatLng(Get.arguments["lat"], Get.arguments["long"]),
        zoom: 20,
      );
    } else {
      _determinePosition().then(
        (value) {
          _currentLatLng = CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: 20,
          );
          _controller.future.then((value) {
            value.moveCamera(CameraUpdate.newCameraPosition(_currentLatLng));
          });
        },
        onError: (e) {
          _currentLatLng = CameraPosition(
            target: LatLng(29.3759, 47.9774),
            zoom: 20,
          );
          _controller.future.then((value) {
            value.moveCamera(CameraUpdate.newCameraPosition(_currentLatLng));
          });
        },
      );
    }

    _centerLocation = _currentLatLng.target;
    super.initState();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Utils.showSnackBar('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.satellite,
                    initialCameraPosition: _currentLatLng,
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (CameraPosition position) {
                      _centerLocation = position.target;
                    },
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add_location,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ).marginOnly(bottom: 20),
                  ),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MyButton(
              title: "confirm".tr,
              onClick: () {
                Get.back(
                  result: MapEntry(
                    (_centerLocation?.latitude ?? 0.0).toString(),
                    (_centerLocation?.longitude ?? 0.0).toString(),
                  ),
                );
              },
            ).marginAll(16),
          ],
        ),
      ),
    );
  }
}
