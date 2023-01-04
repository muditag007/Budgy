// ignore_for_file: avoid_print, unnecessary_new, unused_field, use_build_context_synchronously, prefer_const_constructors, unnecessary_brace_in_string_interps, invalid_return_type_for_catch_error, await_only_futures, unnecessary_null_comparison

import 'package:budgy1/pages/home_page.dart';
import 'package:budgy1/pages/opening_page.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class NewTestPage extends StatefulWidget {
  const NewTestPage({Key? key}) : super(key: key);
  static String id = 'newtestpage';

  @override
  State<NewTestPage> createState() => _NewTestPageState();
}

class _NewTestPageState extends State<NewTestPage> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final SmsQuery _query = SmsQuery();
  bool progress = false;
  List<SmsMessage> _messages = [];
  final _firestore = FirebaseFirestore.instance;
  late Future dateLastUpdated;
  DateTime lastUpdatedDate = new DateTime(2000, 1, 1);
  // late DateTime lastUpdatedDate;
  // DateTime lastClickedDate = DateTime.now();
  List allMessages = [];
  int totalMessages = 0;
  int addedMessages = 0;

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

  sortingMessages() {
    if (_messages != null) {
      for (var message in _messages) {
        if (message.sender!.contains('IDFC')) {
          String strDate = message.date.toString();
          DateTime date = DateTime.parse(strDate);
          if (lastUpdatedDate.isBefore(date)) {
            print(date);
            List<String> parts = message.body!.split(' ');
            bool credited = true;
            double amount = 0;
            double balance = 0;
            int temp = 0;
            List mess = [];
            if (parts[4] == 'credited' || parts[4] == 'debited') {
              if (parts[4] == 'credited') {
                credited = false;
              }
              for (var part in parts) {
                if (part == 'INR') {
                  String tempAmount = parts[parts.indexOf(part) + 1];
                  String finalAmount = '';
                  for (int i = 0; i < tempAmount.length; i++) {
                    if (tempAmount[i] == ',') {
                      continue;
                    }
                    finalAmount = finalAmount + tempAmount[i];
                  }
                  amount = double.parse(finalAmount);
                }
              }
              // print(parts);
              // print(credited);
              // print(amount);
              // print(message.date);
              mess.add(date);
              mess.add(amount);
              mess.add(credited);
              allMessages.add(mess);
              setState(() {
                totalMessages++;
              });
            }
          }
        }
      }
    }
    print(allMessages);
  }

  addingNewData() async {
    for (int i = 0; i < allMessages.length; i++) {
      String id = '';
      await _firestore
          .collection('transactions')
          .add({
            'date': allMessages[i][0],
            'amount': allMessages[i][1],
            'credited': allMessages[i][2],
            'payee': 'Untitled',
            'category': 'UnCategorised',
            'user': loggedInUser.email,
            'docid': id,
          })
          .then((value) => id = value.id)
          .catchError((error) => print("Failed to Add ${error}"));
      _firestore.collection('transactions').doc(id).update({
        'docid': id,
      });
      setState(() {
        addedMessages++;
      });
    }
  }

  Future getDocs() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("transactions").get();
    // var _docData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // var docs = List.from(_docData);
    // _docData = docs.toList();
    // print(_docData);
    List allData = [];
    for (var doc in querySnapshot.docs) {
      Object? data = doc.data();
      Map<String, dynamic> map = (data! as Map<String, dynamic>);
      allData.add(map);
    }
    allData.sort((a, b) => a['date'].compareTo(b['date']));
    allData = allData.toList();
    // print(allData);
    print("First and Last Date");
    print(allData[0]['date'].toDate());
    print(allData[allData.length - 1]['date'].toDate());
    setState(() {
      lastUpdatedDate = allData[allData.length - 1]['date'].toDate();
    });
    return allData[allData.length - 1]['date'].toDate();
  }

  void fetchDate() async {
    setState(() async {
      lastUpdatedDate = await getDocs();
    });
  }

  @override
  void initState() {
    getCurrentUser();
    fetchDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //   padding: const EdgeInsets.all(10.0),
      //   child: ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: _messages.length,
      //     itemBuilder: (BuildContext context, int i) {
      //       var message = _messages[i];
      //       return ListTile(
      //         title: Text('${message.sender} [${message.date}]'),
      //         subtitle: Text('${message.body}'),
      //       );
      //     },
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: progress
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Fetching New Data',
                      style: GoogleFonts.lato(fontSize: 25, color: kdarkpurple),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // LoadingAnimationWidget.staggeredDotsWave(
                    //   color: kColor2,
                    //   size: 70,
                    // ),
                    Container(
                  height: 100,
                  child: Lottie.asset(
                    'images/budgy_load.json',
                    fit: BoxFit.contain,
                  ),
                ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Messages Retrieved',
                      style: GoogleFonts.lato(fontSize: 25, color: kdarkpurple),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${addedMessages.toString()}/${totalMessages.toString()}',
                      style: GoogleFonts.lato(fontSize: 25, color: kdarkpurple),
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Last Updated on:',
                      style: GoogleFonts.lato(fontSize: 25, color: kdarkpurple),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      lastUpdatedDate.toString(),
                      style: GoogleFonts.lato(fontSize: 25, color: kdarkpurple),
                    ),
                    SizedBox(
                      height: 500,
                    ),
                    Text(
                      'Click on the button to Fetch New Data',
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        color: kdarkpurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // LoadingAnimationWidget.staggeredDotsWave(
                    //   color: kColor2,
                    //   size: 70,
                    // ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: kdarkpurple,
        backgroundColor: kdarkpurple,
        onPressed: () async {
          var permission = await Permission.sms.status;
          if (permission.isGranted) {
            final messages = await _query.querySms(
              kinds: [
                SmsQueryKind.inbox,
                SmsQueryKind.sent,
              ],
              // address: 'AXIDFCFB',
              // address: '+254712345789',
              // count: 10,
            );
            debugPrint('sms inbox messages: ${messages.length}');
            print(lastUpdatedDate);
            print(messages);
            setState(() {
              _messages = messages;
              progress = true;
            });
            // fetchDate();
            // print(lastUpdatedDate);
            sortingMessages();

            await addingNewData();
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushNamed(context, OpeningPage.id);
            });
            // Navigator.pushNamed(context, OpeningPage.id);
          } else {
            await Permission.sms.request();
          }
        },
        child: const Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}
