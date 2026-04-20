import 'package:flutter/material.dart';
import '../app_assets.dart';

extension AppTextStyles on TextStyle {
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: FontFamily.poppins
  );

  static const TextStyle card_title = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: FontFamily.poppins
  );

  static const TextStyle temperature = TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: FontFamily.poppins
  );
}