// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print, unused_element, sized_box_for_whitespace

import 'package:budgy1/utils/button.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class EditPage extends StatefulWidget {
  EditPage({required this.docid});
  final String docid;

  static String id = "editpage";
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String id = '';
  String dropdownValue = "<Select a Category>";
  List<String> list = <String>['<Select a Category>'];
  List<String> listtemp = <String>['<Select a Category>', 'Loading...'];
  final _amountControl = TextEditingController();
  final _titleControl = TextEditingController();
  DateTime dueDate = DateTime.now();
  bool credit = false;
  String payee = '';
  double amount = 0;
  List list1 = [];
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    dueDate = args.value;
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

  Future<void> _categoryList(List arr) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('categories').get();
    var docs = querySnapshot.docs;
    var categorySorted = [];
    for (var cat in docs) {
      if(cat['user']==loggedInUser.email){
        categorySorted.add(cat['category'].toString());
      }
    }
    categorySorted.sort();
    for (var x in categorySorted) {
      arr.add(x);
    }
    print(arr);
  }

  Future<List> _initialization() async {
    await _firestore
        .collection('transactions')
        .doc(widget.docid)
        .get()
        .then((value) => {_titleControl.text = value['payee']});
    await _firestore
        .collection('transactions')
        .doc(widget.docid)
        .get()
        .then((value) => {_amountControl.text = value['amount'].toString()});
    await _firestore
        .collection('transactions')
        .doc(widget.docid)
        .get()
        .then((value) => {dueDate = value['date'].toDate()});
    await _firestore
        .collection('transactions')
        .doc(widget.docid)
        .get()
        .then((value) => {dropdownValue = value['category']});
    await _firestore
        .collection('transactions')
        .doc(widget.docid)
        .get()
        .then((value) => {credit = value['credited']});
    payee = _titleControl.text;
    await _firestore
        .collection('transactions')
        .doc(widget.docid)
        .get()
        .then((value) => {amount = value['amount']});
    print(dueDate);
    print(amount);
    print(credit);
    print(dropdownValue);
    print(_amountControl.text);
    print(_titleControl.text);
    List temp = [];
    temp.add(dueDate);
    temp.add(amount);
    temp.add(credit);
    temp.add(dropdownValue);
    temp.add(_amountControl.text);
    temp.add(_titleControl.text);
    return temp;
  }

  void _method() async {
    await _categoryList(list);
    await _initialization();
  }

  @override
  void initState() {
    // _categoryList(list);
    // await _initialization();
    _method();
    getCurrentUser();
    print(dueDate);
    // amount = double.parse(_amountControl.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (dropdownValue == "UnCategorised" ||
                dropdownValue == "UnCategorized") {
              dropdownValue = "<Select a Category>";
            }
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
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _titleControl,
                        cursorColor: kdarkpurple,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            payee = value;
                          });
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "eg. VIT",
                          labelText: "Enter Name of Payee",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _amountControl,
                        cursorColor: kdarkpurple,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            amount = double.parse(value);
                          });
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "eg. ₹100",
                          labelText: "Enter Amount",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Button(
                            button: false,
                            name: '+10',
                            onpress: () {
                              setState(() {
                                if (amount == 0) {
                                  _amountControl.text = '0.0';
                                  _amountControl.text =
                                      (double.parse(_amountControl.text) + 10)
                                          .toString();
                                  amount = double.parse(_amountControl.text);
                                } else {
                                  _amountControl.text =
                                      (double.parse(_amountControl.text) + 10)
                                          .toString();
                                  amount = double.parse(_amountControl.text);
                                }
                              });
                            },
                          ),
                          Button(
                            button: false,
                            name: '+50',
                            onpress: () {
                              setState(() {
                                if (amount == 0) {
                                  _amountControl.text = '0.0';
                                  _amountControl.text =
                                      (double.parse(_amountControl.text) + 50)
                                          .toString();
                                  amount = double.parse(_amountControl.text);
                                } else {
                                  _amountControl.text =
                                      (double.parse(_amountControl.text) + 50)
                                          .toString();
                                  amount = double.parse(_amountControl.text);
                                }
                              });
                            },
                          ),
                          Button(
                            button: false,
                            name: '+100',
                            onpress: () {
                              setState(() {
                                if (amount == 0) {
                                  _amountControl.text = '0.0';
                                  _amountControl.text =
                                      (double.parse(_amountControl.text) + 100)
                                          .toString();
                                  amount = double.parse(_amountControl.text);
                                } else {
                                  _amountControl.text =
                                      (double.parse(_amountControl.text) + 100)
                                          .toString();
                                  amount = double.parse(_amountControl.text);
                                }
                              });
                            },
                          ),
                          Button(
                            button: false,
                            name: '+500',
                            onpress: () {
                              setState(() {
                                if (amount == 0) {
                                  _amountControl.text = '0.0';
                                  _amountControl.text =
                                      (double.parse(_amountControl.text) + 500)
                                          .toString();
                                  amount = double.parse(_amountControl.text);
                                } else {
                                  _amountControl.text =
                                      (double.parse(_amountControl.text) + 500)
                                          .toString();
                                  amount = double.parse(_amountControl.text);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                        isExpanded: true,
                        alignment: Alignment.center,
                        dropdownColor: Colors.white,
                        value: dropdownValue,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: kdarkpurple,
                            fontSize: 20,
                          ),
                        ),
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
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
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Credited - ",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          FlutterSwitch(
                            activeColor: kdarkpurple,
                            inactiveColor: kColor3,
                            width: 100,
                            // borderRadius: 10,
                            // activeToggleColor: kColor3,
                            // inactiveToggleColor: kColor2,

                            onToggle: (bool value) {
                              setState(() {
                                credit = value;
                              });
                            },
                            // showOnOff: true,
                            value: credit,
                          ),
                          Text(
                            " - Debited",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SfDateRangePicker(
                        selectionColor: kColor3,
                        // backgroundColor: kColor2,
                        todayHighlightColor: kColor3,
                        selectionShape: DateRangePickerSelectionShape.rectangle,
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.single,
                        initialSelectedDate: dueDate,
                      ),
                      Button(
                        button: true,
                        name: 'Update',
                        onpress: () {
                          print(dropdownValue.toString());
                          _firestore
                              .collection('transactions')
                              .doc(widget.docid)
                              .update({
                            'payee': _titleControl.text,
                            'amount': amount,
                            'credited': credit,
                            'date': dueDate,
                            'category': dropdownValue.toString() ==
                                    "<Select a Category>"
                                ? "UnCategorised"
                                : dropdownValue.toString(),
                            'docid': widget.docid,
                            'user': loggedInUser.email,
                          });
                          Navigator.pop(context);
                        },
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
        });
  }
}
