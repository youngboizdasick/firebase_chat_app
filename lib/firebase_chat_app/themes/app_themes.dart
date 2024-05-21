import 'package:firebase_chat_app/firebase_chat_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData() {
  return ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily,
    scaffoldBackgroundColor: ColorConstants.themeColor,
    appBarTheme: _appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    snackBarTheme: snackBarThemeData(),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    color: ColorConstants.themeColor,
    elevation: 0,
    titleSpacing: 0,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: ColorConstants.primaryColor.withOpacity(0.6),
    ),
  );
}

DividerThemeData dividerThemeData() {
  return DividerThemeData(color: ColorConstants.secondaryColor);
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.spacing),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.radius),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.radius),
      borderSide: BorderSide(color: Colors.transparent),
    ),
  );
}

SnackBarThemeData snackBarThemeData() {
  return SnackBarThemeData(
    backgroundColor: ColorConstants.themeColor,
    behavior: SnackBarBehavior.floating,
    elevation: 0,
  );
}
