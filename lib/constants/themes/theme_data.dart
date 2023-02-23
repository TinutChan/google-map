import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        overflow: TextOverflow.ellipsis,
      ),
      displayMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
        
      ),
    ),
  );
}
