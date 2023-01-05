// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:budgy1/pages/edit_profile.dart';
import 'package:budgy1/pages/manage_cats.dart';
import 'package:budgy1/pages/new_test_page.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = 'profilepage';
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  String name = '';
  String? email = '';
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        setState(() {
          email = loggedInUser.email;
        }); //print(loggedInUser.email);
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
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
          bottom: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Hero(
                  tag: 'profile',
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(50),
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
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('users').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var users = snapshot.data!.docs;
                          var users1 = List.from(users);
                          for (var k in users1) {
                            if (k['email'] == loggedInUser.email) {
                              name = k['name'];
                            }
                          }
                          return Text(
                            "$name",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return Text(
                            "Loading...",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      "${email}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                // Material(
                //   child: InkWell(
                //     child: Container(
                //       height: 50,
                //       width: 50,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(50),
                //         color: kdarkpurple,
                //       ),
                //       child: Icon(
                //         CupertinoIcons.pen,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              child: InkWell(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kwhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Manage Categories",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, ManageCats.id);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              child: InkWell(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kwhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Retrive New Messages",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, NewTestPage.id);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              child: InkWell(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kwhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Clear All Transactions",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  if (loggedInUser.email != '') {
                    var snapshots =
                        await _firestore.collection('transactions').get();
                    List temp = snapshots.docs.toList();
                    for (var k in temp) {
                      if (k['user'] == loggedInUser.email) {
                        print("hello");
                        print(k['user']);
                        await _firestore
                            .collection('transactions')
                            .doc(k['docid'])
                            .delete();
                      }
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, EditProfile.id);
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kwhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                        ),
                      ],
                    ),
                  ),
                  // color: kwhite,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              child: InkWell(
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kwhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  // color: kwhite,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              "All Copyright Rights Reserved ©",
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
