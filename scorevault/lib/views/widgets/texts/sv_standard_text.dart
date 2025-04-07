import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SvStandardText extends StatelessWidget {
  final String text;
  final double size;
  final Color textColor;
  const SvStandardText({super.key, required this.text, required this.size, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sora(
        fontSize: size,
        color:textColor,
        fontWeight: FontWeight.w500
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