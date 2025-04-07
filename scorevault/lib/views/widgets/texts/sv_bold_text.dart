import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SvBoldText extends StatelessWidget {
  final String text;
  final double size;
  final Color textColor;
  const SvBoldText({super.key, required this.text, required this.size, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sora(
        fontSize: size,
        color:textColor,
        fontWeight: FontWeight.bold
      )
    );
  }

  static TextStyle getTextStyle({required double size, required Color textColor}) {
    return GoogleFonts.sora(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.bold
      );
  }
}