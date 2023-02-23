import 'package:flutter/material.dart';

import 'constants/themes/theme_data.dart';
import 'modules/google_map/screens/my_location_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: const MyLocationAddress(),
      debugShowCheckedModeBanner: false,
    );
  }
}
