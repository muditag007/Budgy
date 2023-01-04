// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unused_element, sort_child_properties_last, prefer_if_null_operators, prefer_const_literals_to_create_immutables, avoid_print, await_only_futures, unused_field, unnecessary_brace_in_string_interps, invalid_return_type_for_catch_error, use_build_context_synchronously

import 'package:budgy1/pages/opening_page.dart';
import 'package:budgy1/utils/button.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewCat extends StatefulWidget {
  const NewCat({super.key});
  static String id = 'newcat';

  @override
  State<NewCat> createState() => _NewCatState();
}

class _NewCatState extends State<NewCat> {
  String category = '';
  double budget = 0;
  Icon? _icon;
  String id = '';
  final _textController = TextEditingController();
  final _numController = TextEditingController();
  bool color = false;
  late User loggedInUser;
  final _auth = FirebaseAuth.instance;
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

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      budget = double.parse(value);
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       width: 150,
                //       height: 50,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20),
                //         border: Border.all(
                //           color: Colors.black,
                //         ),
                //         color: kwhite,
                //       ),
                //       child: Center(
                //         child: _icon == Icon(null)
                //             ? Text(
                //                 'Pick One Icon',
                //                 style: TextStyle(
                //                   fontSize: 20,
                //                 ),
                //               )
                //             : _icon,
                //       ),
                //     ),
                //     Material(
                //       borderRadius: BorderRadius.circular(20),
                //       color: kpurple,
                //       child: MaterialButton(
                //         elevation: 5,
                //         child: Text(
                //           "Select Icon",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 25,
                //           ),
                //         ),
                //         onPressed: _pickIcon,
                //       ),
                //     ),
                //   ],
                // ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    category,
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
                                      color: color ? kdarkblue : kdarkorange,
                                    ),
                                  ),
                                ],
                              )
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
                                progressColor: color ? kdarkblue : kdarkorange,
                                backgroundColor: color ? klightblue : korange,
                                barRadius: Radius.circular(20),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                      "Add Category",
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
                            .add({
                              'category': category,
                              'docid': id,
                              'budget': budget,
                              'user': loggedInUser.email,
                            })
                            .then((value) => id = value.id)
                            .catchError(
                                (error) => print("Failed to Add ${error}"));
                        _firestore
                            .collection('categories')
                            .doc(id)
                            .update({'docid': id});
                      }
                      Navigator.pushNamed(context, OpeningPage.id);
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
      ),
    );
  }
}
