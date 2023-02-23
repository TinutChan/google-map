import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_map/modules/google_map/models/address_model.dart';

class AddressController extends GetxController {
  final addressController = TextEditingController().obs;
  final locationDetailController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  var addressModel = AddressModel().obs;
  var isLoading = false.obs;
//Testing
  String googleApikey = "API_KEY";
  var latitude = 11.5815697.obs;
  var longitude = 104.9017115.obs;
  var latitudePosition = 0.0.obs;
  var longitudePosition = 0.0.obs;
  var address = "".obs;
  var isCheckMaker = false.obs;
  // var modelAddress = <AddressModel>[].obs;
  var emptyList = <AddressModel>[].obs;
  var itemCount = 0.obs;
  var isChecked = false.obs;

  clear() {
    address.value = '';
    // locationDetailController.close();
  }

  Future<void> getAddressFromLatLng(double lat, double lng) async {
    try {
      await placemarkFromCoordinates(lat, lng)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];

        address.value =
            '${place.street}, ${place.subLocality},${place.administrativeArea}, ${place.country}'
                .toString();

        debugPrint(
            "Full Address:$address ${place.street}, ${place.administrativeArea},${place.name}, ${place.country}");
      });
    } catch (e) {
      debugPrint("Full Address:$e");
    } finally {
      debugPrint("Full ");
    }
  }

  addNewAddress(
      {required String address, required String location, String? desc}) {
    // AddressModel(addressName: address, locationDetail: location, desc: desc);
    emptyList.add(AddressModel(addressName: address, locationDetail: location));
    // itemCount.value = emptyList.length;
    // debugPrint('emptyList====: ${itemCount.value}');
    // debugPrint('LocationDetail: ${locationDetailController.value.text}');
    // debugPrint('List $emptyList');
  }
}
