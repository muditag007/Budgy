// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'package:budgy1/pages/cat_detail.dart';
import 'package:budgy1/pages/edit_cat.dart';
import 'package:budgy1/pages/new_cat.dart';
import 'package:budgy1/pages/newui.dart';
import 'package:budgy1/pages/opening_page.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetCard extends StatelessWidget {
  final Color col1;
  final Color col2;
  final String str;
  final String amt;
  final String total;
  final String bud;
  final bool press;
  final String docid;
  const BudgetCard({
    required this.amt,
    required this.bud,
    required this.col1,
    required this.col2,
    required this.str,
    required this.total,
    required this.press,
    required this.docid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          press
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatDetail(
                      text: str,
                      amt: amt,
                      budget: bud,
                      col1: col1,
                      col2: col2,
                      total: total,
                      docid: docid,
                    ),
                  ),
                )
              : null;
        },
        child: Hero(
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            return SingleChildScrollView(
              child: fromHeroContext.widget,
            );
          },
          tag: str,
          child: Container(
            height: 250,
            width: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: col1,
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            str.length > 15
                                ? str.substring(0, 15) + "..."
                                : str,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            "₹${amt} per day",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: col2,
                            ),
                          ),
                        ],
                      ),
                      if (str != 'UnCategorised')
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditCat(
                                    docid: docid,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: col2,
                              ),
                              child: Icon(
                                CupertinoIcons.pen,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: kwhite),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearPercentIndicator(
                        lineHeight: 40,
                        percent: (double.parse(total) / double.parse(bud) > 1)
                            ? 1
                            : (double.parse(total) / double.parse(bud) < 0
                                ? 0
                                : double.parse(total) / double.parse(bud)),
                        center: Align(
                          child: Text(
                            "     ₹${total}",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        // isRTL: true,
                        progressColor: col2,
                        backgroundColor: col1,
                        barRadius: Radius.circular(20),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Spent ₹${total} from ",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "₹${bud}",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: kpurple,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
