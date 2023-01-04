// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_local_variable, avoid_print, unnecessary_new, sized_box_for_whitespace, invalid_required_positional_param, unnecessary_brace_in_string_interps

import 'package:budgy1/pages/limit_page.dart';
import 'package:budgy1/pages/list_page.dart';
import 'package:budgy1/utils/column_chart.dart';
import 'package:budgy1/utils/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartData {
  ChartData(@required this.x, @required this.y);
  final String x;
  final String y;
  // final Color color;
}

class AveragePage extends StatefulWidget {
  const AveragePage({Key? key}) : super(key: key);
  static String id = "averagepage";
  @override
  State<AveragePage> createState() => _AveragePageState();
}

class _AveragePageState extends State<AveragePage> {
  List<String> list = <String>['Week', 'Month', 'Quarter', 'Year', 'All Time'];
  String dropdownValue = 'Week';
  List cat = [];
  // bool chartView = true;
  List chart = [];
  double average = 0;
  double calculatedAverage = 0;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kpurple,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Center(
          child: Text(
            "Budgy",
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.visibility,
        //       color: kColor2,
        //     ),
        //     onPressed: () {
        //       setState(() {
        //         chartView = !chartView;
        //       });
        //     },
        //   )
        // ],
        automaticallyImplyLeading: false,
        backgroundColor: kpurple,
      ),
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
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: 30,
                    // ),
                    Text(
                      "   Current Average",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            // color: Colors.white,
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    // SizedBox(
                    //   height: 80,
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 223,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kdarkblue,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _firestore
                                  .collection('transactions')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text(
                                    "NaN",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      color: Colors.black,
                                      fontSize: 80,
                                    ),
                                  );
                                } else {
                                  average = 0;
                                  var notSortedTransactions =
                                      snapshot.data!.docs;
                                  notSortedTransactions.sort(((a, b) =>
                                      a['date'].compareTo(b['date'])));
                                  var transactions1 =
                                      List.from(notSortedTransactions);
                                  List transactions =
                                      transactions1.reversed.toList();
                                  // int days = 0;
                                  DateTime last =
                                      transactions[0]['date'].toDate();
                                  DateTime lastDate =
                                      new DateTime(last.year, last.month, 1);
                                  // DateTime lastDate = lastDate1;
                                  if (dropdownValue == 'Month') {
                                    lastDate =
                                        new DateTime(last.year, last.month, 1);
                                  } else if (dropdownValue == 'Quarter') {
                                    lastDate = new DateTime(
                                        last.year, last.month - 2, 1);
                                  } else if (dropdownValue == 'Year') {
                                    lastDate = new DateTime(
                                        last.year - 1, last.month + 1, 1);
                                  } else if (dropdownValue == 'Week') {
                                    if (last.weekday == DateTime.sunday) {
                                      lastDate = new DateTime(
                                          last.year, last.month, last.day);
                                    } else if (last.weekday ==
                                        DateTime.monday) {
                                      lastDate = new DateTime(
                                          last.year, last.month, last.day - 1);
                                    } else if (last.weekday ==
                                        DateTime.tuesday) {
                                      lastDate = new DateTime(
                                          last.year, last.month, last.day - 2);
                                    } else if (last.weekday ==
                                        DateTime.wednesday) {
                                      lastDate = new DateTime(
                                          last.year, last.month, last.day - 3);
                                    } else if (last.weekday ==
                                        DateTime.thursday) {
                                      lastDate = new DateTime(
                                          last.year, last.month, last.day - 4);
                                    } else if (last.weekday ==
                                        DateTime.friday) {
                                      lastDate = new DateTime(
                                          last.year, last.month, last.day - 5);
                                    } else if (last.weekday ==
                                        DateTime.saturday) {
                                      lastDate = new DateTime(
                                          last.year, last.month, last.day - 6);
                                    }
                                  } else {
                                    lastDate =
                                        transactions[transactions.length - 1]
                                                ['date']
                                            .toDate();
                                  }
                                  DateTime cutDate =
                                      transactions[0]['date'].toDate();
                                  Duration days = cutDate.difference(lastDate);
                                  print(lastDate);
                                  print(transactions);
                                  print(cutDate);
                                  // String lastYear = lastDate.substring(6);
                                  // String lastMonth = lastDate.substring(3, 5);
                                  // String lastDay = '';
                                  cat = [];
                                  bool newCat = true;
                                  int i = 0;
                                  for (var tran in transactions) {
                                    DateTime transactionDate =
                                        tran['date'].toDate();
                                    if (lastDate.isBefore(transactionDate)) {
                                      if (tran['category'] == "Transfer") {
                                        continue;
                                      }
                                      for (i = 0; i < cat.length; i++) {
                                        if (tran['category'] != cat[i][0]) {
                                          newCat = true;
                                        } else {
                                          newCat = false;
                                          break;
                                        }
                                      }
                                      if (newCat) {
                                        List temp = [];
                                        temp.add(tran['category']);
                                        if (tran['credited']) {
                                          temp.add(tran['amount']);
                                        } else {
                                          temp.add(tran['amount'] * -1);
                                        }
                                        cat.add(temp);
                                      } else {
                                        if (tran['credited']) {
                                          cat[i][1] =
                                              cat[i][1] + tran['amount'];
                                        } else {
                                          cat[i][1] =
                                              cat[i][1] - tran['amount'];
                                        }
                                      }

                                      if (tran['credited']) {
                                        average = average + tran['amount'];
                                      } else {
                                        average = average - tran['amount'];
                                      }
                                    } else {
                                      // cutDate = tran['date'].toDate();
                                      break;
                                    }
                                    days = cutDate.difference(lastDate);
                                  }
                                  print(days.inDays);
                                  print(average);
                                  average = average / (days.inDays + 1);
                                  print(cat);
                                  print(average);
                                  return Text(
                                    average.toStringAsFixed(2),
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          // color: Colors.black,
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                "for this",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    // color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton(
                                dropdownColor: kdarkblue,
                                value: dropdownValue,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    // color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.white,
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value.toString();
                                  });
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              height: 300,
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   // ignore: prefer_const_literals_to_create_immutables
                //   colors: [
                //     Color.fromRGBO(51, 59, 155, 0.7),
                //     Color.fromRGBO(51, 59, 155, 1),
                //   ],
                //   begin: Alignment.centerLeft,
                //   end: Alignment.centerRight,
                // ),
                // color: Colors.white,
                color: klightblue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('transactions').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "NaN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                          ),
                        );
                      } else {
                        average = 0;
                        var notSortedTransactions = snapshot.data!.docs;
                        notSortedTransactions
                            .sort(((a, b) => a['date'].compareTo(b['date'])));
                        var transactions1 = List.from(notSortedTransactions);
                        List transactions = transactions1.reversed.toList();
                        // int days = 0;
                        DateTime last = transactions[0]['date'].toDate();
                        DateTime lastDate =
                            new DateTime(last.year, last.month, 1);
                        // DateTime lastDate = lastDate1;
                        if (dropdownValue == 'Month') {
                          lastDate = new DateTime(last.year, last.month, 1);
                        } else if (dropdownValue == 'Quarter') {
                          lastDate = new DateTime(last.year, last.month - 2, 1);
                        } else if (dropdownValue == 'Year') {
                          lastDate =
                              new DateTime(last.year - 1, last.month + 1, 1);
                        } else if (dropdownValue == 'Week') {
                          if (last.weekday == DateTime.sunday) {
                            lastDate =
                                new DateTime(last.year, last.month, last.day);
                          } else if (last.weekday == DateTime.monday) {
                            lastDate = new DateTime(
                                last.year, last.month, last.day - 1);
                          } else if (last.weekday == DateTime.tuesday) {
                            lastDate = new DateTime(
                                last.year, last.month, last.day - 2);
                          } else if (last.weekday == DateTime.wednesday) {
                            lastDate = new DateTime(
                                last.year, last.month, last.day - 3);
                          } else if (last.weekday == DateTime.thursday) {
                            lastDate = new DateTime(
                                last.year, last.month, last.day - 4);
                          } else if (last.weekday == DateTime.friday) {
                            lastDate = new DateTime(
                                last.year, last.month, last.day - 5);
                          } else if (last.weekday == DateTime.saturday) {
                            lastDate = new DateTime(
                                last.year, last.month, last.day - 6);
                          }
                        } else {
                          lastDate = transactions[transactions.length - 1]
                                  ['date']
                              .toDate();
                        }
                        DateTime cutDate = transactions[0]['date'].toDate();
                        Duration days = cutDate.difference(lastDate);
                        print(lastDate);
                        print(transactions);
                        print(cutDate);
                        // String lastYear = lastDate.substring(6);
                        // String lastMonth = lastDate.substring(3, 5);
                        // String lastDay = '';
                        cat = [];
                        bool newCat = true;
                        int i = 0;
                        // for (var tran in transactions) {
                        //   DateTime transactionDate = tran['date'].toDate();
                        //   if (lastDate.isBefore(transactionDate) &&
                        //       tran['category'] != "Transfer") {
                        //     for (i = 0; i < cat.length; i++) {
                        //       if (tran['category'] != cat[i][0]) {
                        //         newCat = true;
                        //       } else {
                        //         newCat = false;
                        //         break;
                        //       }
                        //     }
                        //     if (newCat) {
                        //       List temp = [];
                        //       temp.add(tran['category']);
                        //       if (tran['credited']) {
                        //         temp.add(tran['amount']);
                        //       } else {
                        //         temp.add(tran['amount'] * -1);
                        //       }
                        //       cat.add(temp);
                        //     } else {
                        //       if (tran['credited']) {
                        //         cat[i][1] = cat[i][1] + tran['amount'];
                        //       } else {
                        //         cat[i][1] = cat[i][1] - tran['amount'];
                        //       }
                        //     }
                        //   } else {
                        //     break;
                        //   }
                        //   days = cutDate.difference(lastDate);
                        // }
                        for (var tran in transactions) {
                          DateTime transactionDate = tran['date'].toDate();
                          if (lastDate.isBefore(transactionDate)) {
                            if (tran['category'] == "Transfer") {
                              continue;
                            }
                            for (i = 0; i < cat.length; i++) {
                              if (tran['category'] != cat[i][0]) {
                                newCat = true;
                              } else {
                                newCat = false;
                                break;
                              }
                            }
                            if (newCat) {
                              List temp = [];
                              temp.add(tran['category']);
                              if (tran['credited']) {
                                temp.add(tran['amount']);
                              } else {
                                temp.add(tran['amount'] * -1);
                              }
                              cat.add(temp);
                            } else {
                              if (tran['credited']) {
                                cat[i][1] = cat[i][1] + tran['amount'];
                              } else {
                                cat[i][1] = cat[i][1] - tran['amount'];
                              }
                            }
                          } else {
                            break;
                          }
                          days = cutDate.difference(lastDate);
                        }

                        print(days.inDays);
                        print(cat);

                        List<Widget> newCatList = [];
                        for (int i = 0; i < cat.length; i++) {
                          average = cat[i][1] / (days.inDays + 1);
                          List<Widget> temp = [];
                          temp.add(Text('${cat[i][0]}'));
                          // temp.add(cat[i][1]);
                          temp.add(Text('${average}'));
                          newCatList.add(Row(
                            children: temp,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ));
                        }
                        print(newCatList);
                        return PieChart(
                          data: cat,
                        );
                      }
                    },
                  ),
                ),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(70, 96, 135, 1),
                  // color: kpurple,
                  color: kwhite,
                  // color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     // width: 100,
            //     child: Center(
            //       child: Container(
            //         child: StreamBuilder<QuerySnapshot>(
            //           stream: _firestore.collection('transactions').snapshots(),
            //           builder: (context, snapshot) {
            //             if (!snapshot.hasData) {
            //               return Text(
            //                 "NaN",
            //                 style: GoogleFonts.lato(
            //                   textStyle: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 80,
            //                   ),
            //                 ),
            //               );
            //             } else {
            //               average = 0;
            //               var notSortedTransactions = snapshot.data!.docs;
            //               notSortedTransactions
            //                   .sort(((a, b) => a['date'].compareTo(b['date'])));
            //               var transactions1 = List.from(notSortedTransactions);
            //               List transactions = transactions1.reversed.toList();
            //               // int days = 0;
            //               DateTime lastDate = transactions[0]['date'].toDate();
            //               DateTime cutDate = transactions[0]['date'].toDate();
            //               print(transactions);
            //               print(cutDate);
            //               chart = [];
            //               int i = 0;
            //               double sum = 0;
            //               for (var tran in transactions) {
            //                 if (i > 6) {
            //                   break;
            //                 } else {
            //                   for (var same in transactions) {
            //                     if (same['date'] == lastDate) {
            //                       sum = sum + same['amount'];
            //                     } else {
            //                       List temp = [];
            //                       temp.add(lastDate.weekday.toString());
            //                       temp.add(sum);
            //                       chart.add(temp);
            //                       sum = 0;
            //                       DateTime temporary = new DateTime(
            //                           lastDate.year,
            //                           lastDate.month,
            //                           lastDate.day - 1);
            //                       lastDate = temporary;
            //                       break;
            //                     }
            //                   }
            //                   i++;
            //                 }
            //               }

            //               return ColumnChart(data: chart,);
            //             }
            //           },
            //         ),
            //         height: 200,
            //         width: 300,
            //       ),
            //     ),
            //     decoration: BoxDecoration(
            //       color: kColor2,
            //       // color: Colors.red,
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(20),
            //         bottomLeft: Radius.circular(20),
            //         bottomRight: Radius.circular(80),
            //         topRight: Radius.circular(20),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
