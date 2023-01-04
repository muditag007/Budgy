import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(color: kdarkpurple),
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kdarkpurple, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kdarkpurple, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kTextFieldDecoLogin = InputDecoration(
  labelStyle: TextStyle(color: Colors.black),
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kColor1 = Color.fromRGBO(130, 137, 169, 1);
// const kColor2 = Color.fromARGB(220, 57, 62, 70);
const kdarkpurple = Color.fromRGBO(51, 59, 155, 1);
const kColor3 = Color.fromRGBO(70, 96, 135, 1);
const kColor4 = Color.fromARGB(255, 224, 240, 253);

const klightblue = Color.fromARGB(255, 198, 230, 255);
// const kdarkpurple = Color.fromRGBO(51, 59, 155, 1);
const korange = Color.fromARGB(255, 255, 218, 219);
const kdarkblue = Color.fromARGB(255, 106, 195, 251);
const kpurple = Color.fromARGB(255, 104, 82, 205);
const kdarkorange = Color.fromARGB(167, 179, 136, 156);
const kwhite = Color.fromARGB(255, 244, 243, 250);
