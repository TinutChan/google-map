// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/components/custom_button.dart';
import 'package:google_map/modules/google_map/controller/map_controller.dart';

import '../../../components/custom_textfield.dart';
import 'components/google_map.dart';
import 'googlemap_screen.dart';

class CreateNewAddressScreen extends StatefulWidget {
  const CreateNewAddressScreen({super.key});

  @override
  State<CreateNewAddressScreen> createState() => _CreateNewAddressScreenState();
}

final addressController = Get.put(AddressController());

class _CreateNewAddressScreenState extends State<CreateNewAddressScreen> {
  // Future<void> getAddressFromLatLng(LatLng position) async {
  //   try {
  //     await placemarkFromCoordinates(position.latitude, position.longitude)
  //         .then((List<Placemark> placemarks) {
  //       Placemark place = placemarks[0];
  //       setState(() {
  //         stAddress =
  //             '${place.street}, ${place.administrativeArea},${place.name}, ${place.country}'
  //                 .toString();
  //       });
  //       debugPrint("Full Address:$stAddress");
  //     });
  //   } catch (e) {
  //     debugPrint("Error :$e");
  //   } finally {
  //     debugPrint("Error final  :");
  //   }
  // }

  // getAddressFromLatLngs() async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(11.55072, 104.8969216
  //             // _currentPosition!.latitude,
  //             // _currentPosition!.longitude
  //             );

  //     Placemark place = placemarks[0];

  //     setState(() {
  //       _currentAddress =
  //           "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //     debugPrint('nanatib :  ${ _currentAddress}');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    addressController.clear();
    addressController.getAddressFromLatLng(
        addressController.latitudePosition.value,
        addressController.longitudePosition.value);
    super.initState();
  }

  String? _currentAddress;
  String? stAddress = '';
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: CustomGoogleMap(
                          isScrolled: false,
                          isEnable: false,
                          onTab: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const GoogleMapScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomTextField(
                        textEditingController:
                            addressController.addressController.value,
                        hintText: 'Address Name',
                        obscureText: false,
                        readOnly: false,
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () => CustomTextField(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const GoogleMapScreen();
                                },
                              ),
                            );
                          },
                          textEditingController:
                              addressController.locationDetailController.value,
                          readOnly: true,
                          hintText: addressController.address.value,
                          labelText: 'Location',
                          obscureText: false,
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomTextField(
                        textEditingController:
                            addressController.descriptionController.value,
                        hintText: 'description',
                        readOnly: false,
                        obscureText: false,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            addressController.isChecked.value =
                                !addressController.isChecked.value;
                          });
                        },
                        child: addressController.isChecked.value == false
                            ? Container(
                                width: double.infinity,
                                height: 100,
                                color: Colors.blue,
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    addressController.isChecked.value = false;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  color: Colors.green,
                                ),
                              ),
                      ),
                      const Spacer(),
                      CustomButton(
                        onPressed: () {
                          debugPrint(
                              "1${addressController.addressController.value.text}");
                          debugPrint("1${addressController.address.value}");

                          addressController.addNewAddress(
                              address: addressController
                                  .addressController.value.text,
                              location: addressController.address.value,
                              desc: '');
                          debugPrint(
                              'Nantib Nantib:${addressController.locationDetailController.value.text}::${addressController.addressController.value.text}::${addressController.address.value}');
                          addressController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Save Address'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
