import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/components/custom_button.dart';
import 'package:google_map/constants/themes/theme_data.dart';
import 'package:google_map/modules/google_map/controller/map_controller.dart';

import 'create_new_address.dart';

class MyLocationAddress extends StatefulWidget {
  const MyLocationAddress({super.key});

  @override
  State<MyLocationAddress> createState() => _MyLocationAddressState();
}

final getController = Get.put(AddressController());

class _MyLocationAddressState extends State<MyLocationAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: getController.emptyList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: getController.isChecked.value == true
                                ? Image.asset(
                                    getController.emptyList[index].icons!)
                                : CircleAvatar(
                                    child: Text(
                                      addressController
                                          .emptyList[index].addressName![0],
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getController.emptyList[index].addressName!,
                                style: theme().textTheme.displayLarge,
                              ),
                              Text(
                                getController.emptyList[index].locationDetail!,
                                style: theme().textTheme.displayMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CreateNewAddressScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('Add new Address'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
