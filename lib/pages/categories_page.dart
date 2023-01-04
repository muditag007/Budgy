// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, unnecessary_brace_in_string_interps, invalid_return_type_for_catch_error, avoid_unnecessary_containers

import 'package:budgy1/utils/button.dart';
import 'package:budgy1/utils/category_tile.dart';
import 'package:budgy1/utils/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);
  static String id = "categoriespage";
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _firestore = FirebaseFirestore.instance;
  final _textController = TextEditingController();
  String newCat = '';
  String id = '';
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

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: kpurple,
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            "Budgy",
            style: TextStyle(
              color: Colors.white,
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
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "All Categories",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('categories').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    "NaN",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                      ),
                    ),
                  );
                } else {
                  var categories = snapshot.data!.docs;
                  List<Widget> category = [];
                  // List<String> categorySorted = [];
                  for (var cat in categories) {
                    // category.add(
                    //   Center(
                    //     child: Text(
                    //       cat,
                    //       style: GoogleFonts.lato(
                    //         textStyle: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
                    if(loggedInUser.email==cat['user']){
                      category.add(
                      CategoryTile(
                        name: cat['category'],
                        id: cat['docid'],
                      ),
                    );
                    }
                  }
                  return Expanded(
                    child: ListView(
                      children: category,
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: klightblue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:10,vertical: 20,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      textCapitalization: TextCapitalization.characters,
                      controller: _textController,
                      cursorColor: kdarkpurple,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        newCat = value;
                      },
                      decoration: kTextFieldDecoLogin.copyWith(
                        hintText: "eg. Travel",
                        labelText: "Enter New Category",
                      ),
                    ),
                    Expanded(child: Container(),),
                    Button(
                      name: "Add New Category",
                      onpress: () async {
                        if (_textController.text != '') {
                          await _firestore
                              .collection('categories')
                              .add({
                                'category': newCat,
                                'docid': id,
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
                        _textController.text = '';
                      },
                      button: true,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
