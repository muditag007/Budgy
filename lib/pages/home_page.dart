// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:budgy1/pages/add_new.dart';
import 'package:budgy1/pages/average_page.dart';
import 'package:budgy1/pages/categories_page.dart';
import 'package:budgy1/pages/limit_page.dart';
import 'package:budgy1/pages/list_page.dart';
import 'package:budgy1/pages/new_test_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "homepage";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Center(
      //     child: Text(
      //       "Budgy",
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      // ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 5,
        ),
        child: Column(
          children: [
            // SizedBox(height: 30,),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AveragePage.id);
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
                      "   Calculate monthwise",
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
                      "   Average",
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
                height: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(51, 59, 155, 0.7),
                        Color.fromRGBO(51, 59, 155, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    // color: Color.fromARGB(0, 181, 45, 45),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(80),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
                        height: 15,
                      ),
                      Text(
                        "   Manage Categories",
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
                      // Text(
                      //   "   Average",
                      //   style: GoogleFonts.lato(
                      //     textStyle: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 25,
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
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
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
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
                  Navigator.pushNamed(context, NewTestPage.id);
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "   Retrive New Data",
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
                        "   from Messages",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   "   Messages",
                      //   style: GoogleFonts.lato(
                      //     textStyle: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 25,
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Container(),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Icon(
                      //       Icons.arrow_forward_ios,
                      //       color: Colors.white,
                      //       size: 25,
                      //     ),
                      //     SizedBox(
                      //       width: 50,
                      //     ),
                      //   ],
                      // ),
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromRGBO(51, 59, 155, 1),
      //   child: Icon(
      //     Icons.add,
      //   ),
      //   onPressed: () {
      //     Navigator.pushNamed(context, AddNew.id);
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //   backgroundColor: Color.fromRGBO(130, 137, 169, 1),
      //   activeIndex: _bottomNavIndex,
      //   icons: [
      //     Icons.delete,
      //     Icons.flip_camera_ios,
      //   ],
      //   gapLocation: GapLocation.center,
      //   onTap: (index) {
      //     setState(() {
      //       _bottomNavIndex = index;
      //     });
      //   },
      //   notchSmoothness: NotchSmoothness.defaultEdge,
      // ),
    );
  }
}
