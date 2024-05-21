import 'package:firebase_chat_app/firebase_chat_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  const HeaderTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: GoogleFonts.salsa().fontFamily,
        fontSize: 40,
        color: ColorConstants.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
