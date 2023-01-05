// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, await_only_futures, avoid_print, sized_box_for_whitespace, use_build_context_synchronously

import 'package:budgy1/pages/opening_page.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});
  static String id = 'createprofile';

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  String name = '';
  double budget = 0;
  String id = '';
  TextEditingController _textController = TextEditingController();
  TextEditingController _numController = TextEditingController();

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
                SizedBox(height: 15,),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _textController,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: kTextFieldDecoLogin.copyWith(
                    hintText: "Mudit Agrawal",
                    labelText: "Enter your name",
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
                    labelText: "Enter your monthly expense target",
                  ),
                ),
                SizedBox(
                  height: 15,
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
                      "Create User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    onPressed: () async {
                      if (_textController.text != '' &&
                          _numController.text != '') {
                        await _firestore
                            .collection('users')
                            .add({
                              'name': name,
                              'docid': id,
                              'budget': budget,
                              'email': loggedInUser.email,
                              'dp': "images/visalogo.png",
                            })
                            .then((value) => id = value.id)
                            .catchError(
                                (error) => print("Failed to Add ${error}"));
                        _firestore
                            .collection('users')
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
