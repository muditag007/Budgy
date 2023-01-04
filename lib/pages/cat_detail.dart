// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_brace_in_string_interps, unnecessary_null_comparison, prefer_interpolation_to_compose_strings

import 'package:budgy1/pages/edit_cat.dart';
import 'package:budgy1/pages/new_cat.dart';
import 'package:budgy1/utils/budget_card.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:budgy1/utils/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CatDetail extends StatefulWidget {
  final String text;
  final String amt;
  final String total;
  final String budget;
  final Color col1;
  final Color col2;

  const CatDetail(
      {super.key,
      required this.text,
      required this.amt,
      required this.budget,
      required this.col1,
      required this.col2,
      required this.total});
  static String id = 'catdetail';

  @override
  State<CatDetail> createState() => _CatDetailState();
}

class _CatDetailState extends State<CatDetail> {
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

  // String str = 'Icon(IconData(U+0F733))';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: korange,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Center(
          child: Text(
            "Budgy",
            style: TextStyle(
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
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
              ) {
                return SingleChildScrollView(
                  child: toHeroContext.widget,
                );
              },
              tag: widget.text,
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
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
                        color: widget.col1,
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
                                widget.text.length > 15
                                    ? widget.text.substring(0, 15) + "..."
                                    : widget.text,
                                style: TextStyle(
                                  fontSize: 25,
                                  // fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                "₹${widget.amt} per day",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: widget.col2,
                                ),
                              ),
                            ],
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, EditCat.id);
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: widget.col2,
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
                            percent: (double.parse(widget.total) /
                                        double.parse(widget.budget) >
                                    1)
                                ? 1
                                : ((double.parse(widget.total) /
                                            double.parse(widget.budget) <
                                        0)
                                    ? 0
                                    : double.parse(widget.total) /
                                        double.parse(widget.budget)),
                            center: Align(
                              child: Text(
                                "     ₹${widget.total}",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            // isRTL: true,
                            progressColor: widget.col2,
                            backgroundColor: widget.col1,
                            barRadius: Radius.circular(20),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Spent ₹${widget.total} from ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "₹${widget.budget}",
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
            SizedBox(
              height: 10,
            ),
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
                if (transactions[0]['category'] == widget.text) {
                  transactionWidget.add(
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${day}-${mon}, ${year}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                for (var tran in transactions) {
                  if (transactionWidget == null &&
                      tran['user'] == loggedInUser.email &&
                      tran['category'] == widget.text) {
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
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  String transactionDate =
                      DateFormat('dd-MM-yyyy').format(tran['date'].toDate());

                  if (transactionDate == date &&
                      tran['user'] == loggedInUser.email &&
                      tran['category'] == widget.text) {
                    // print("helloo");
                    transactionWidget.add(
                      TransactionTile(
                        name: tran['payee'],
                        amount: tran['amount'].toString(),
                        credited: !tran['credited'],
                        id: tran['docid'],
                      ),
                    );
                  } else if (tran['user'] == loggedInUser.email &&
                      tran['category'] == widget.text) {
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
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );

                    if (tran['user'] == loggedInUser.email &&
                        tran['category'] == widget.text) {
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
            // Expanded(
            //   child: Container(),
            // ),
          ],
        ),
      ),
    );
  }
}
