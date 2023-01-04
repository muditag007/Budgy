// ignore_for_file: prefer_const_constructors, unused_field, sized_box_for_whitespace

import 'package:budgy1/utils/budget_card.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class ManageCats extends StatefulWidget {
  const ManageCats({super.key});
  static String id = 'managecats';
  @override
  State<ManageCats> createState() => _ManageCatsState();
}

class _ManageCatsState extends State<ManageCats> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

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
        automaticallyImplyLeading: false,
        backgroundColor: kpurple,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('categories').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var categories = snapshot.data!.docs;
              var cats = List.from(categories);
              List catsUser = [];
              for (var cat in cats) {
                if (cat['user'] == loggedInUser.email &&
                    cat['category'] != 'Transfer') {
                  catsUser.add(cat);
                }
              }
              return Column(
                children: [
                  Text(
                    "Total Categories : ${(catsUser.length)}",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: catsUser.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: BudgetCard(
                            press: false,
                            amt: '100',
                            bud: (catsUser[index]['budget']).toString(),
                            col1: index % 2 == 0 ? korange : klightblue,
                            col2: index % 2 == 0 ? kdarkorange : kdarkblue,
                            // icon: CupertinoIcons.paperplane,
                            str: catsUser[index]['category'],
                            total: '100',
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Container(
                  height: 200,
                  child: Lottie.asset(
                    'images/budgy_load.json',
                    fit: BoxFit.contain,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
