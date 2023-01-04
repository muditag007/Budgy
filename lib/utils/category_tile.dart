// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:budgy1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({required this.name, required this.id});
  String name;
  String id;
  final _firestore = FirebaseFirestore.instance;

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
          color: kdarkorange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(width: 20,),
              Container(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                  color: korange,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: kdarkorange,
                  ),
                  onPressed: () {
                    _firestore.collection('categories').doc(id).delete();
                  },
                ),
              ),
              // SizedBox(width: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
