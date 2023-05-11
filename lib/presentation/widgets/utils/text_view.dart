import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  const TextView({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: textAlign,
      style: GoogleFonts.quicksand(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: decoration,
      ),
    );
  }
}
