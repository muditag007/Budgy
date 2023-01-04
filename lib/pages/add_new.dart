// ignore_for_file: prefer_const_constructors, unused_field

import 'package:budgy1/utils/button.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);
  static String id = "addnew";
  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  String id = '';
  String dropdownValue = "<Select a Category>";
  List<String> list = <String>['<Select a Category>'];
  final _amountControl = TextEditingController();
  DateTime dueDate = DateTime.now();
  bool credit = false;
  String payee = "";
  double amount = 0;
  final _firestore = FirebaseFirestore.instance;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    dueDate = args.value;
  }

  void _categoryList(List arr) async {
    // StreamBuilder<QuerySnapshot>(
    //   stream: _firestore.collection('categories').snapshots(),
    //   builder: (context, snapshot) {
    //     var categ = snapshot.data!.docs;
    // List<String> categorySorted = [];
    // for (var cat in categ) {
    //   categorySorted.add(cat['category'].toString());
    // }
    // categorySorted.sort();
    // for (var x in categorySorted) {
    //   list.add(x);
    // }
    //     return Container();
    //   },
    // );
    QuerySnapshot querySnapshot =
        await _firestore.collection('categories').get();
    var docs = querySnapshot.docs;
    var categorySorted = [];
    for (var cat in docs) {
      categorySorted.add(cat['category'].toString());
    }
    categorySorted.sort();
    for (var x in categorySorted) {
      arr.add(x);
    }
    // print(list);
  }

  @override
  void initState() {
    _categoryList(list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Button(
              //       button: false,
              //       name: 'Enzo',
              //       onpress: () {},
              //     ),
              //     Button(
              //       button: false,
              //       name: 'Chips',
              //       onpress: () {},
              //     ),
              //     Button(
              //       button: false,
              //       name: 'McD/Dominos',
              //       onpress: () {},
              //     ),
              //     Button(
              //       button: false,
              //       name: 'Travel',
              //       onpress: () {},
              //     ),
              //   ],
              // ),
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
              // SizedBox(
              //   height: 20,
              // ),
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
                items: list.map<DropdownMenuItem<String>>((String value) {
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
                initialSelectedDate: DateTime.now(),
              ),
              Button(
                button: true,
                name: 'Add',
                onpress: () async {
                  await _firestore
                      .collection('transactions')
                      .add({
                        'payee': payee,
                        'amount': amount,
                        'credited': credit,
                        'date': dueDate,
                        'category':
                            dropdownValue.toString() == "<Select a Category>"
                                ? "UnCategorized"
                                : dropdownValue.toString(),
                        'docid':id,
                      })
                      .then((value) => id = value.id)
                      .catchError((error) => print("Failed to Add ${error}"));
                  _firestore
                      .collection('transactions')
                      .doc(id)
                      .update({'docid': id});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
