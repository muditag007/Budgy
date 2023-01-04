// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_brace_in_string_interps, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, avoid_print, sort_child_properties_last, sized_box_for_whitespace

import 'package:budgy1/utils/constants.dart';
import 'package:budgy1/utils/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);
  static String id = "listpage";
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _firestore = FirebaseFirestore.instance;
  late String month;
  late User loggedInUser;
  final _auth = FirebaseAuth.instance;

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

  String getMonth(m) {
    if (m == "01")
      month = "Jan";
    else if (m == "02")
      month = "Feb";
    else if (m == "03")
      month = "Mar";
    else if (m == "04")
      month = "Apr";
    else if (m == "05")
      month = "May";
    else if (m == "06")
      month = "Jun";
    else if (m == "07")
      month = "Jul";
    else if (m == "08")
      month = "Aug";
    else if (m == "09")
      month = "Sep";
    else if (m == "10")
      month = "Oct";
    else if (m == "11")
      month = "Nov";
    else
      month = "Dec";

    return month;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: klightblue,
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            "Budgy",
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 0,
          top: 5,
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    // Positioned(
                    //   // width: MediaQuery.of(context).size.width-20,
                    //   child: Container(
                    //     height: 200,
                    //     child: Image.asset(
                    //       'images/visalogo.png',
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      top: 15,
                      left: 20,
                      child: Text(
                        "Current Balance",
                        style: GoogleFonts.inconsolata(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 20,
                      child: Text(
                        "₹ 25,234.00",
                        style: GoogleFonts.inconsolata(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      child: Text(
                        "**** **** **** ****",
                        style: GoogleFonts.inconsolata(
                            color: Colors.white,
                            fontSize: 30,
                            letterSpacing: 1),
                      ),
                    ),
                    Positioned(
                      top: 135,
                      left: 20,
                      child: Text(
                        "Card Holder",
                        style: GoogleFonts.inconsolata(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 155,
                      left: 20,
                      child: Text(
                        "MUDIT AGRAWAL",
                        style: GoogleFonts.inconsolata(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [
                      Color.fromARGB(255, 37, 72, 160),
                      Color.fromARGB(255, 34, 41, 99),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  // color: Color.fromARGB(255, 34,41,99),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 200,
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('transactions').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: kdarkpurple, size: 70),
                  );
                }
                var notSortedTransactions = snapshot.data!.docs;
                notSortedTransactions
                    .sort(((a, b) => a['date'].compareTo(b['date'])));
                var transactions1 = List.from(notSortedTransactions);
                List transactions = transactions1.reversed.toList();
                List<Widget> transactionWidget = [];
                String date = DateFormat('dd-MM-yyyy')
                    .format(transactions[0]['date'].toDate());
                // DateTime date = transactions[0]['date'].toDate();
                String day = date.substring(0, 2);
                String mon = getMonth(date.substring(3, 5));
                String year = date.substring(6);
                transactionWidget.add(
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${day}-${mon}, ${year}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                for (var tran in transactions) {
                  if (transactionWidget == null &&
                      tran['user'] == loggedInUser.email) {
                    String date =
                        DateFormat('dd-MM-yyyy').format(tran['date'].toDate());
                    String formattedDate = date.substring(0, 2);
                    String formattedMonth = date.substring(3, 5);
                    String formattedYear = date.substring(6);
                    formattedMonth = getMonth(formattedMonth);
                    transactionWidget.add(
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${formattedDate}-${formattedMonth}, ${formattedYear}",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  // print(transactionWidget);
                  String transactionDate =
                      DateFormat('dd-MM-yyyy').format(tran['date'].toDate());

                  if (transactionDate == date &&
                      tran['user'] == loggedInUser.email) {
                    // print("helloo");
                    transactionWidget.add(
                      TransactionTile(
                        name: tran['payee'],
                        amount: tran['amount'].toString(),
                        credited: !tran['credited'],
                        id: tran['docid'],
                      ),
                    );
                  } else if (tran['user'] == loggedInUser.email) {
                    String formattedDate = transactionDate.substring(0, 2);
                    String formattedMonth = transactionDate.substring(3, 5);
                    formattedMonth = getMonth(formattedMonth);
                    String formattedYear = transactionDate.substring(6);
                    transactionWidget.add(
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${formattedDate}-${formattedMonth}, ${formattedYear}",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (tran['user'] == loggedInUser.email) {
                      final wid = TransactionTile(
                        name: tran['payee'],
                        amount: tran['amount'].toString(),
                        credited: !tran['credited'],
                        id: tran['docid'],
                      );
                      date = transactionDate;
                      transactionWidget.add(wid);
                    }
                  }
                }
                return Expanded(
                  child: ListView(
                    // reverse: true,
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    children: transactionWidget,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
