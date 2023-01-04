// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sort_child_properties_last

import 'package:budgy1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  Button({required this.name, required this.onpress, required this.button});

  final String name;
  final bool button;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: kdarkblue,
      child: MaterialButton(
        elevation: 5,
        minWidth: button ? 500 : 0,
        height: button ? 40 : 0,
        child: Text(
          name,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        onPressed: onpress,
      ),
    );
  }
}
