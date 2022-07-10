import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  const PlayerTextWidget({
    Key? key, required this.text, required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poppins(
          textStyle:  TextStyle(
              fontSize: 22, color:color, fontWeight: FontWeight.bold),
        ));
  }
}
