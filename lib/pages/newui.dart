// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, await_only_futures, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_is_empty, unrelated_type_equality_checks, unnecessary_new, prefer_typing_uninitialized_variables, unused_element

import 'package:budgy1/pages/average_page.dart';
import 'package:budgy1/pages/manage_cats.dart';
import 'package:budgy1/pages/new_cat.dart';
import 'package:budgy1/pages/opening_page.dart';
import 'package:budgy1/pages/profile_page.dart';
import 'package:budgy1/utils/budget_card.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewUI extends StatefulWidget {
  const NewUI({super.key});
  static String id = 'newui';
  @override
  State<NewUI> createState() => _NewUIState();
}

class _NewUIState extends State<NewUI> {
  late User loggedInUser;
  final _auth = FirebaseAuth.instance;
  double average = 0;
  double calculatedAverage = 0;
  List cat = [];
  List list = [];
  late Duration days;

  final _firestore = FirebaseFirestore.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _categoryList(List arr) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('categories').get();
    var docs = querySnapshot.docs;
    var categorySorted = [];
    for (var cat in docs) {
      if (cat['user'] == loggedInUser.email) {
        categorySorted.add(cat);
      }
    }
    // categorySorted.sort();
    for (var x in categorySorted) {
      arr.add(x);
    }
    print(categorySorted[1]['user']);
    print(arr);
  }

  @override
  void initState() {
    getCurrentUser();
    _categoryList(list);
    print("hello");
    print(list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AveragePage.id,
                      );
                    },
                    child: Container(
                      height: 400,
                      child: Image.asset(
                        'images/image1.png',
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ProfilePage.id);
                    },
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(15),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection('users').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var image;
                              var users = snapshot.data!.docs;
                              var users1 = List.from(users);
                              for (var x in users1) {
                                if (x['email'] == loggedInUser.email) {
                                  image = x['dp'];
                                }
                              }
                              return Image.asset(
                                'images/visalogo.png',
                                fit: BoxFit.cover,
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 47,
                  left: 115,
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 25,
                  // child:
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('transactions').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "₹ 000",
                          style: TextStyle(
                            // color: Colors.white,
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
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
                        lastDate = new DateTime(last.year, last.month, 1);
                        DateTime cutDate = transactions[0]['date'].toDate();
                        days = cutDate.difference(lastDate);
                        // print(lastDate);
                        // print(transactions);
                        // print(cutDate);
                        cat = [];
                        bool newCat = true;
                        int i = 0;
                        for (var tran in transactions) {
                          DateTime transactionDate = tran['date'].toDate();
                          if (lastDate.isBefore(transactionDate)) {
                            if (tran['category'] == 'Transfer') {
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
                        // print(days.inDays);
                        // // average = average / (days.inDays + 1);
                        // print(cat);
                        String tex = '';
                        if (average > 0) {
                          tex = "₹ " + average.toStringAsFixed(2) + " ↓";
                        } else {
                          average = average * -1;
                          tex = "₹ " + average.toStringAsFixed(2) + " ↑";
                        }

                        return Text(
                          tex,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold
                          ),
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 25,
                  child: Text(
                    "Out of ₹ 10,000 budgeting",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // alignment: Alignment.centerLeft,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Budget Details",
                    style: TextStyle(
                      fontSize: 25,
                      // fontWeight: FontWeight.w500,
                      color: Colors.black,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => kpurple),
                      // minimumSize: MaterialStateProperty.resolveWith(
                      //     (states) => Size.fromHeight(50)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ManageCats.id);
                    },
                    // Navigator.pushNamed(context, OpeningPage.id);
                    child: Text(
                      "Categories",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: 250,
                // color: kpurple,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('transactions').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: 100,
                        child: Lottie.asset(
                          'images/budgy_load.json',
                          fit: BoxFit.contain,
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
                      lastDate = new DateTime(last.year, last.month, 1);
                      DateTime cutDate = transactions[0]['date'].toDate();
                      days = cutDate.difference(lastDate);
                      print(lastDate);
                      print(transactions);
                      print(cutDate);
                      cat = [];
                      bool newCat = true;
                      int i = 0;
                      for (var tran in transactions) {
                        DateTime transactionDate = tran['date'].toDate();
                        if (lastDate.isBefore(transactionDate)) {
                          if (tran['category'] == 'Transfer') {
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
                      print(list);
                      return CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 400.0,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.9,
                        ),
                        itemCount: cat.length + 1,
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          if (index < cat.length) {
                            double amt = cat[index][1] / days.inDays;
                            double total = cat[index][1];
                            String budget = '1000';
                            if (cat[index][0] != 'UnCategorised') {
                              return StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection('categories')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var cats = snapshot.data!.docs;
                                    var categories = List.from(cats);
                                    for (var x in categories) {
                                      if (x['user'] == loggedInUser.email &&
                                          x['category'] == cat[index][0]) {
                                        budget = x['budget'].toString();
                                        
                                        print(budget);
                                        
                                      }
                                    }
                                    return BudgetCard(
                                      press: true,
                                      total: total.toStringAsFixed(2),
                                      amt: amt.toStringAsFixed(2),
                                      bud: budget,
                                      col1:
                                          index % 2 == 0 ? korange : klightblue,
                                      col2: index % 2 == 0
                                          ? kdarkorange
                                          : kdarkblue,
                                      // icon: CupertinoIcons.paperplane,
                                      str: cat[index][0],
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              );
                            } else {
                              return BudgetCard(
                                press: true,
                                total: total.toStringAsFixed(2),
                                amt: amt.toStringAsFixed(2),
                                bud: budget,
                                col1: index % 2 == 0 ? korange : klightblue,
                                col2: index % 2 == 0 ? kdarkorange : kdarkblue,
                                // icon: CupertinoIcons.paperplane,
                                str: cat[index][0],
                              );
                            }
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pushNamed(context, NewCat.id);
                                },
                                child: Container(
                                  height: 250,
                                  width: 270,
                                  decoration: BoxDecoration(
                                    // color: klightblue,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey,
                                    //     blurRadius: 1,
                                    //     spreadRadius: 1,
                                    //   ),
                                    // ],
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
                                          color: index % 2 == 0
                                              ? korange
                                              : klightblue,
                                        ),
                                        height: 100,
                                        child: Center(
                                          child: Text(
                                            "Out of Categories!!",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                          color: kwhite,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Click here to create a Custom Category.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
