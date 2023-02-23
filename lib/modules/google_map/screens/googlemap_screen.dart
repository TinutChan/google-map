import 'package:flutter/material.dart';

import 'components/google_map.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomGoogleMap(
        isEnable: true,
        isScrolled: true,
      ),
    );
  }
}
