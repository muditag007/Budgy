// ignore_for_file: prefer_const_constructors, unused_field, use_build_context_synchronously, unnecessary_null_comparison, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:budgy1/pages/newui.dart';
import 'package:budgy1/pages/opening_page.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  static String id = 'registrationpage';
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isChecked = false;
  String email = "";
  String password = "";
  String confirmPass = '';
  bool spinner = false;
  final _auth = FirebaseAuth.instance;
  bool pass = false;
  bool finalpass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome! Please enter your details.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: kTextFieldDecoLogin.copyWith(
                    hintText: "eg. abcd@gmail.com",
                    labelText: "Enter Email ID",
                    // focusColor: Colors.black
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // TextField(
                //   cursorColor: Colors.black,
                //   keyboardType: TextInputType.text,
                //   textAlign: TextAlign.center,
                //   onChanged: (value) {},
                //   decoration: kTextFieldDecoLogin.copyWith(
                //     hintText: "eg. hello12",
                //     labelText: "Enter Username",
                //     // focusColor: Colors.black
                //   ),
                // ),
                // SizedBox(height: 15,),
                TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.left,
                  obscureText: pass ? false : true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: kTextFieldDecoLogin.copyWith(
                    hintText: "eg. abcd1234",
                    labelText: "Enter Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                      icon: Icon(
                        pass ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                      ),
                    ),
                    // focusColor: Colors.black
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.left,
                  obscureText: finalpass ? false : true,
                  onChanged: (value) {
                    setState(() {
                      confirmPass = value;
                    });
                  },
                  decoration: kTextFieldDecoLogin.copyWith(
                    hintText: "eg. abcd1234",
                    labelText: "Re-Enter Password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          finalpass = !finalpass;
                        });
                      },
                      icon: Icon(
                        finalpass ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                      ),
                    ),
                    // focusColor: Colors.black
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Checkbox(
                      // checkColor: Colors.black,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: Text(
                        "Keep me logged in",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // Expanded(child: Container()),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Text(
                    //     "Forgot Password?",
                    //     style: TextStyle(
                    //       fontSize: 15,
                    //       color: kpurple,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => kpurple),
                    minimumSize: MaterialStateProperty.resolveWith(
                        (states) => Size.fromHeight(50)),
                  ),
                  onPressed: () async {
                    setState(() {
                      spinner = true;
                    });
                    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email) &&
                        RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                            .hasMatch(password) &&
                        password == confirmPass) {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, OpeningPage.id);
                        }
                        setState(() {
                          spinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          spinner = false;
                        });
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Error",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              content: Text(
                                e.toString().contains(
                                        'The email address is already in use')
                                    ? "The Email ID is already registered on the app."
                                    : "",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: kpurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            );
                          },
                        );
                      }
                    } else {
                      setState(() {
                          spinner = false;
                        });
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Error",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            content: Text(
                              "Invalid Email ID",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: kpurple,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 100,
                  child: Visibility(
                    visible: spinner ? true : false,
                    child: Lottie.asset(
                      'images/budgy_load.json',
                      fit: BoxFit.contain,
                    ),
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

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.black;
    }
    return Colors.black;
  }
}
