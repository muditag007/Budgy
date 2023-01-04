// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:budgy1/pages/add_new.dart';
import 'package:budgy1/pages/average_page.dart';
import 'package:budgy1/pages/categories_page.dart';
import 'package:budgy1/pages/home_page.dart';
import 'package:budgy1/pages/limit_page.dart';
import 'package:budgy1/pages/list_page.dart';
import 'package:budgy1/pages/new_test_page.dart';
import 'package:budgy1/pages/newui.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({Key? key}) : super(key: key);
  static String id = "openingpage";
  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  final PageController _pageController = PageController();
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Center(
      //     child: Text(
      //       _bottomNavIndex==0?"Budgy":"Transaction History",
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      // ),
      body: PageView(
        controller: _pageController,
        children: [
          NewUI(),
          ListPage(),
        ],
        onPageChanged: (page) {
          setState(() {
            _bottomNavIndex = page;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kpurple,
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AddNew.id);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        // splashColor: kColor2,
        elevation: 50,
        iconSize: 30,
        // shadow: [],
        icons: [
          Icons.home,
          Icons.history,
        ],
        gapLocation: GapLocation.center,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
            );
          });
        },
        notchSmoothness: NotchSmoothness.defaultEdge,
      ),
    );
  }
}
