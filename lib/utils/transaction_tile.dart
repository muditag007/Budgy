// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_brace_in_string_interps, invalid_required_positional_param, no_leading_underscores_for_local_identifiers

import 'package:budgy1/pages/edit_page.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionTile extends StatelessWidget {
  String id;
  String name;
  String amount;
  bool credited;
  final _firestore = FirebaseFirestore.instance;
  TransactionTile({
    required this.id,
    required this.amount,
    required this.credited,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          // color: credited?Colors.greenAccent:Colors.redAccent,
          color: credited ? kdarkblue : kpurple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              name,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  credited ? Icons.add : null,
                  color: Colors.white,
                  size: 15,
                ),
                Text(
                  amount,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditPage(
                            docid: id,
                          );
                        },
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _firestore.collection('transactions').doc(id).delete();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
