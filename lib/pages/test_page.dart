// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TestPage extends StatefulWidget {
  static String id = "testpage";
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  final _firestore = FirebaseFirestore.instance;
  String id = '';

  @override
  void initState() {
    super.initState();
  }

  addNew(credit, amount, date) async {
    String docid = '';
    await _firestore
        .collection('transac')
        .add({
          'amount': amount,
          'credited': credit,
          'date': date,
          'docid': docid,
        })
        .then((value) => docid = value.id)
        .catchError((error) => print("Failed to Add ${error}"));
    print(docid);
    _firestore.collection('transactions').doc(docid).update({'docid': docid});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
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
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('transac').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.deepPurple,
                ),
              );
            }
            var notSortedTransactions = snapshot.data!.docs;
            notSortedTransactions
                .sort(((a, b) => a['date'].compareTo(b['date'])));
            var transactions1 = List.from(notSortedTransactions);
            List transactions = transactions1.toList();
            DateTime lastUpdatedDate;
            //     transactions[transactions.length - 1]['date'];
            if (transactions == null) {
              lastUpdatedDate = new DateTime(2000, 1, 1);
            } else {
              lastUpdatedDate = transactions[transactions.length - 1]['date'].toDate();
            }

            for (var message in _messages) {
              String strDate = message.date.toString();
              DateTime date = DateTime.parse(strDate);
              if (lastUpdatedDate.isBefore(date)) {
                List<String> parts = message.body!.split(' ');
                bool credited = false;
                double amount = 0;
                double balance = 0;
                int temp = 0;

                if (parts[4] == 'credited' || parts[4] == 'debited') {
                  if (parts[4] == 'credited') {
                    credited = true;
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
                  print(parts);
                  print(credited);
                  print(amount);
                  print(message.date);
                  addNew(credited, amount, message.date);
                }
              }
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var permission = await Permission.sms.status;
            if (permission.isGranted) {
              final messages = await _query.querySms(
                kinds: [
                  SmsQueryKind.inbox,
                ],
                address: 'AXIDFCFB',
                // address: '+254712345789',
                // count: 10,
              );
              debugPrint('sms inbox messages: ${messages.length}');

              setState(() => _messages = messages);
            } else {
              await Permission.sms.request();
            }
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
