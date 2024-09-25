import 'package:doctorappointmenapp/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData customTheme() {
    return ThemeData(
      primaryColor: kBlueColor,
      scaffoldBackgroundColor: kGreyColor500,
      cardColor: whiteColor,
      appBarTheme: AppBarTheme(
        backgroundColor: kBlueColor,
        foregroundColor: whiteColor, // Text color in AppBar
      ),
      iconTheme: IconThemeData(
        color: kBlueColor, // Default icon color
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kGreenColor, // Button color
        ),
      ),
    );
  }
}
