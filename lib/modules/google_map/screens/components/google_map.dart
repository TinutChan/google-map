// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/modules/google_map/screens/create_new_address.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../components/custom_button.dart';
import '../map.dart';

import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

class CustomGoogleMap extends StatefulWidget {
  final bool? isEnable;
  final bool? isScrolled;
  final VoidCallback? onTab;
  const CustomGoogleMap({
    Key? key,
    this.onTab,
    this.isScrolled = false,
    this.isEnable = false,
  }) : super(key: key);

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  final Geolocator geolocator = Geolocator();

  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      await placemarkFromCoordinates(position.latitude, position.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        setState(() {
          stAddress =
              '${place.street}, ${place.administrativeArea},${place.name}, ${place.country}'
                  .toString();
        });
        debugPrint("Full Address:$stAddress");
      });
    } catch (e) {
      debugPrint("Error :$e");
    } finally {
      debugPrint("Error final  :$e");
    }
  }

  final myCurrnetLoacation =
      const LatLng(11.588000535464978, 104.89708251231646);

  Set<Marker> markers = {};

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void setMarker() async {
    final position = await _determinePosition();
    debugPrint('LatLong: ${position.latitude}, ${position.longitude}');
    markers.add(
      Marker(
        position: LatLng(position.latitude, position.longitude),
        markerId: const MarkerId('MyCurrentLocation'),
      ),
    );
    setState(() {});
  }

  void onMovedCamera() async {
    final position = await _determinePosition();
    _googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude), 14));
  }

  Set<Marker> marker = {};
  Uint8List? markerIcon;
  Future<Uint8List> getBytesFromAsset(
    String path,
    int width,
  ) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> addMarker(startLocation) async {
    markers.add(
      Marker(
        anchor: const Offset(0.52, 0.7),
        markerId: MarkerId('$startLocation'),
        position: startLocation,
        //draggable: true,
        onDragEnd: (value) {
          debugPrint('======== onDragEnd : $value');
        },
        icon: BitmapDescriptor.fromBytes(markerIcon!),
      ),
    );
  }

  fire() async {
    markerIcon = await getBytesFromAsset('assets/icons/pin_icon.png', 120);
    if (addressController.latitudePosition.value != 0.0) {
      addressController.isCheckMaker.value = true;
      addMarker(LatLng(addressController.latitudePosition.value,
              addressController.longitudePosition.value))
          .then((value) {
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    setMarker();

    MapUtils.getCurrentLocation().then((value) {
      addressController.latitudePosition.value = value.latitude;
      addressController.longitudePosition.value = value.longitude;
    });
    onMovedCamera();
    super.initState();
  }

  GoogleMapController? _googleMapController;
  String? stAddress = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            scrollGesturesEnabled: widget.isScrolled!,
            onMapCreated: MapUtils.onCreatedGoogleMap,
            onTap: (v) {
              debugPrint('========getLatLng: $v');
              v;
            },
            onCameraMove: (value) {
              debugPrint(
                  '===Latlng on Moved: ${value.target.latitude}, ${value.target.longitude} \\${addressController.latitudePosition.value}');
              addressController.latitudePosition.value = value.target.latitude;
              addressController.longitudePosition.value =
                  value.target.longitude;
            },
            mapType: MapType.normal,
            markers: addressController.isCheckMaker.value ? markers : marker,
            initialCameraPosition: CameraPosition(
              target: myCurrnetLoacation,
              zoom: 16,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 120,
            right: 120,
            child: widget.isEnable == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        addressController.isCheckMaker.value =
                            !addressController.isCheckMaker.value;
                      });
                    },
                    // child: addressController.isCheckMaker.value == false
                    //     ? Container(
                    //         width: double.infinity,
                    //         height: 100,
                    //         color: Colors.white,
                    //         child: addressController.latitudePosition.value == 0
                    //             ? const Text('Non')
                    //             : Text('hi:${addressController.address}'),
                    //       )
                    //     :
                    child: CustomButton(
                      onPressed: () {
                        setState(() {
                         addressController.getAddressFromLatLng(
                              addressController.latitudePosition.value,
                              addressController.longitudePosition.value);
                          addressController.isCheckMaker.value = false;
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        // height: 100,
                        color: Colors.green,
                        child: const Text('Save Address'),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      floatingActionButton: widget.isEnable!
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                onMovedCamera();
              },
              child: const Icon(
                Icons.my_location,
                color: Colors.black,
              ),
            )
          : const SizedBox(),
    );
  }
}
