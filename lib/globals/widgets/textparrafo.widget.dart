import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextParrafo extends StatelessWidget {
  const TextParrafo({
    Key? key,
    required this.texto,
    this.colorTexto = Colors.black,
    this.fontWeight,
    this.textAlign,
  }) : super(key: key);

  final String texto;
  final Color colorTexto;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: textAlign,
      softWrap: true,
      style: GoogleFonts.sourceSansPro(
          fontSize: 13, color: colorTexto, fontWeight: fontWeight),
    );
  }
}
