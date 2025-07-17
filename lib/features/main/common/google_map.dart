import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/auth/register/register_controller.dart';
import 'package:garage/features/main/add_new_address/add_new_address_logic.dart';
import 'package:garage/theme/styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  bool _locationGranted = false;
  LatLng? _userLatLng;
  String? _userAddress;
  final getControllerType = Get.arguments;

  @override
  void initState() {
    super.initState();
    _initLocationServices();
  }

  Future<void> _initLocationServices() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Permission denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Permission denied forever");
      openAppSettings();
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final latLng = LatLng(position.latitude, position.longitude);
    final address = await _getAddressFromLatLng(latLng);

    setState(() {
      _userLatLng = latLng;
      _userAddress = address;
      _locationGranted = true;
    });

    // Move camera after map is created and location is set
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLngZoom(latLng, 14));
    }
  }

  Future<String?> _getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        print(
          "❌ Error getting location description: ${"${place.name}, ${place.street}, ${place.locality}, "
              "${place.administrativeArea}, ${place.country}"}",
        );

        return "${place.name}, ${place.street}, ${place.locality}, "
            "${place.administrativeArea}, ${place.country}";
      }
    } catch (e) {
      print("❌ Error getting location description: $e");
    }
    return null;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // If location is already fetched, move camera
    if (_userLatLng != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_userLatLng!, 14),
      );
    }
  }

  void _handleMapTap(LatLng tappedLatLng) async {
    setState(() {
      _userLatLng = tappedLatLng;
      _userAddress = null;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    final address = await _getAddressFromLatLng(tappedLatLng);
    setState(() {
      _userAddress = address;
    });

    // Optionally move the camera too
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(tappedLatLng, 14));
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'select_location'.tr,
      body:
          _locationGranted
              ? Stack(
                children: [
                  GoogleMap(
                    onCameraMove: (position) {
                      setState(() {
                        _userLatLng = position.target;
                        _userAddress = null;
                      });
                    },
                    onCameraIdle: () async {
                      if (_userLatLng != null) {
                        final address = await _getAddressFromLatLng(
                          _userLatLng!,
                        );
                        setState(() {
                          _userAddress = address;
                        });
                      }
                    },
                    zoomControlsEnabled: false,

                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _userLatLng ?? const LatLng(29.3759, 47.9774),
                      zoom: 11.0,
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Center(
                        child: Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    width: Get.width,
                    child: Container(
                      decoration: MyshapesStyle.SecondaryDecoration,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 20.0,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        spacing: 16,
                        children: [
                          Container(
                            decoration: MyshapesStyle.PrimaryDecoration,
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _userAddress ?? "Loading...".tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          MyButton(
                            title: 'confirm'.tr,
                            onClick: () {
                              if (getControllerType == "register") {
                                print("type is register");
                                Get.find<RegisterController>().latLngChanged(
                                  _userLatLng?.latitude ?? 0,
                                  _userLatLng?.longitude ?? 0,
                                  _userAddress,
                                );
                              } else if (getControllerType == "addAddress") {
                                print("type is addAddress");
                                Get.find<AddNewAddressController>()
                                    .latLngChanged(
                                      _userLatLng?.latitude ?? 0,
                                      _userLatLng?.longitude ?? 0,
                                      _userAddress,
                                    );
                              }
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
