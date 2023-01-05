// ignore_for_file: prefer_const_constructors, unused_element, use_build_context_synchronously, unnecessary_brace_in_string_interps, invalid_return_type_for_catch_error, sort_child_properties_last, sized_box_for_whitespace, unused_field, avoid_print, await_only_futures, unused_local_variable

import 'package:budgy1/pages/newui.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lottie/lottie.dart';

class EditCat extends StatefulWidget {
  const EditCat({super.key, required this.docid});
  static String id = 'editcat';
  final String docid;

  @override
  State<EditCat> createState() => _EditCatState();
}

class _EditCatState extends State<EditCat> {
  String category = '';
  double budget = 0;
  String id = '';
  final _textController = TextEditingController();
  final _numController = TextEditingController();
  bool color = false;
  int count = 0;
  late User loggedInUser;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<List> _initialization() async {
    if (count == 0) {
      await _firestore
          .collection('categories')
          .doc(widget.docid)
          .get()
          .then((value) => {category = value['category']});
      await _firestore
          .collection('categories')
          .doc(widget.docid)
          .get()
          .then((value) => {_numController.text = value['budget'].toString()});
      _textController.text = category;
      print(_textController.text);
      print(_numController.text);
      print('count $count');
      List temp = [];
      temp.add(_numController.text);
      temp.add(_textController.text);
      count++;
      print("category:$category");
      budget = double.parse(_numController.text);
      return temp;
    } else {
      List temp = [];
      temp.add(_numController.text);
      temp.add(_textController.text);
      return temp;
    }
  }

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

  @override
  void initState() {
    getCurrentUser();
    _initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initialization(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: _textController,
                          onChanged: (value) {
                            setState(() {
                              category = value;
                            });
                          },
                          decoration: kTextFieldDecoLogin.copyWith(
                            hintText: "Travelling",
                            labelText: "Enter name of Category",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: _numController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              if (_numController.text == '') {
                                budget = 0;
                              } else {
                                budget = double.parse(value);
                              }
                            });
                          },
                          decoration: kTextFieldDecoLogin.copyWith(
                            prefix: Text("₹ "),
                            hintText: "1000",
                            labelText: "Enter budget of Category",
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              color = !color;
                            });
                          },
                          child: Container(
                            height: 250,
                            // width: 300,
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
                                    color: color ? klightblue : korange,
                                  ),
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      // Container(
                                      //     height: 60,
                                      //     width: 60,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(50),
                                      //       color: color ? kdarkblue : kdarkorange,
                                      //     ),
                                      //     child: _icon),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            _textController.text,
                                            style: TextStyle(
                                              fontSize: 20,
                                              // fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          Text(
                                            "₹100 per day",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: color
                                                  ? kdarkblue
                                                  : kdarkorange,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async {
                                            await _firestore
                                                .collection('categories')
                                                .doc(widget.docid)
                                                .get()
                                                .then((value) => {
                                                      category =
                                                          value['category']
                                                    });
                                            var snapshot = await _firestore
                                                .collection('transactions')
                                                .get();
                                            List temp = snapshot.docs.toList();
                                            print(category);
                                            for (var k in temp) {
                                              print("prev category:$category");
                                              if (k['category'] == category) {
                                                await _firestore
                                                    .collection('transactions')
                                                    .doc(k['docid'])
                                                    .update({
                                                  'payee': k['payee'],
                                                  'amount': k['amount'],
                                                  'credited': k['credited'],
                                                  'date': k['date'],
                                                  'category': "UnCategorised",
                                                  'docid': k['docid'],
                                                  'user': loggedInUser.email,
                                                });
                                                print("idharrrrrrr");
                                              }
                                            }
                                            print(temp);
                                            await _firestore
                                                .collection('categories')
                                                .doc(widget.docid)
                                                .delete();
                                            Navigator.pop(context);
                                          },
                                          splashColor: Colors.transparent,
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: color
                                                  ? kdarkblue
                                                  : kdarkorange,
                                            ),
                                            child: Icon(
                                              CupertinoIcons.delete,
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
                                    color: kwhite,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LinearPercentIndicator(
                                        lineHeight: 40,
                                        percent: 0.5,
                                        center: Align(
                                          child: Text(
                                            "     ₹100",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                        // isRTL: true,
                                        progressColor:
                                            color ? kdarkblue : kdarkorange,
                                        backgroundColor:
                                            color ? klightblue : korange,
                                        barRadius: Radius.circular(20),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            "Spent ₹100 from ",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "₹$budget",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: kpurple,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          color: kpurple,
                          child: MaterialButton(
                            elevation: 5,
                            minWidth: MediaQuery.of(context).size.width,
                            // minWidth: button ? 500 : 0,
                            // height: button ? 40 : 0,
                            child: Text(
                              "Edit Category",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () async {
                              if (_textController.text != '' &&
                                  _numController.text != '') {
                                await _firestore
                                    .collection('categories')
                                    .doc(widget.docid)
                                    .get()
                                    .then((value) =>
                                        {category = value['category']});
                                var snapshot = await _firestore
                                    .collection('transactions')
                                    .get();
                                List temp = snapshot.docs.toList();
                                print(category);
                                for (var k in temp) {
                                  print("prev category:$category");
                                  if (k['category'] == category) {
                                    await _firestore
                                        .collection('transactions')
                                        .doc(k['docid'])
                                        .update({
                                      'payee': k['payee'],
                                      'amount': k['amount'],
                                      'credited': k['credited'],
                                      'date': k['date'],
                                      'category': _textController.text,
                                      'docid': k['docid'],
                                      'user': loggedInUser.email,
                                    });
                                    print("idharrrrrrr");
                                  }
                                }
                                print(temp);
                                await _firestore
                                    .collection('categories')
                                    .doc(widget.docid)
                                    .update({
                                  'category': _textController.text,
                                  'budget': _numController.text,
                                  'docid': widget.docid,
                                  'user': loggedInUser.email,
                                });
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: Container(
                    height: 200,
                    child: Lottie.asset(
                      'images/budgy_load.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
