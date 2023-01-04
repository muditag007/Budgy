// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:budgy1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LimitSetPage extends StatefulWidget {
  const LimitSetPage({Key? key}) : super(key: key);
  static String id = "limitsetpage";

  @override
  State<LimitSetPage> createState() => _LimitSetPageState();
}

class _LimitSetPageState extends State<LimitSetPage> {
  List<Widget> list = [
    Text(
      'Day',
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    ),
    Text(
      'Week',
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    ),
    Text(
      'Month',
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    ),
    Text(
      'Quarter',
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    ),
    Text(
      'Year',
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    )
  ];
  int selected = 1;
  double amount = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            "Budgy",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                initialItem: selected,
              ),
              backgroundColor: Colors.deepPurple,
              useMagnifier: true,
              offAxisFraction: 2,
              itemExtent: 60, 
              // ignore: prefer_const_literals_to_create_immutables
              children: list,
              onSelectedItemChanged: (value) {
                setState(() {
                  selected = value + 1;
                });
              },
            ),
          ),
          Slider(
            value: amount,
            min: 0,
            max: 5000,
            divisions: 501,
            activeColor: kdarkpurple,
            inactiveColor: kColor1,
            // thumbColor: kColor3,
            onChanged: (double value) {
              setState(() {
                amount = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
