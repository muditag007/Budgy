// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:budgy1/pages/categories_page.dart';
import 'package:budgy1/pages/limit_set_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LimitPage extends StatefulWidget {
  const LimitPage({Key? key}) : super(key: key);
  static String id = "limitpage";
  @override
  State<LimitPage> createState() => _LimitPageState();
}

class _LimitPageState extends State<LimitPage> {
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
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 20,
        ),
        child: Column(
          children: [
            // SizedBox(height: 30,),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CategoriesPage.id);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "   Manage All",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "   Categories",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  // height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // ignore: prefer_const_literals_to_create_immutables
                        colors: [
                          Color.fromRGBO(51, 59, 155, 0.7),
                          Color.fromRGBO(51, 59, 155, 1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(80),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, LimitSetPage.id);
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "   Set Limit of",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "   Expenses",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(70, 96, 135, 1),
                      // color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(80),
                        topRight: Radius.circular(20),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
