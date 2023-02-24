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
                          hintText: addressController.address.value != false
                              ? addressController.address.value
                              : 'Location Detail',
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
                      const SizedBox(height: 15.0),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              addressController.isChecked.value =
                                  !addressController.isChecked.value;
                            },
                          );
                        },
                        child: addressController.isChecked.value == false
                            ? Container(
                                width: double.infinity,
                                height: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset('assets/img/home.png'),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    addressController.isChecked.value = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3.0),
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xff00afb9),
                                      width: 4,
                                    ),
                                  ),
                                  child: Image.asset('assets/img/home.png'),
                                ),
                              ),
                      ),
                      const Spacer(),
                      CustomButton(
                        onPressed: () {
                          debugPrint(
                            addressController.addNewAddress(
                              icons: 'assets/img/home.png',
                              address: addressController
                                  .addressController.value.text,
                              location: addressController.address.value,
                              desc: '',
                            ),
                          );
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
