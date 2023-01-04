// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:budgy1/pages/add_new.dart';
import 'package:budgy1/pages/average_page.dart';
import 'package:budgy1/pages/cat_detail.dart';
import 'package:budgy1/pages/categories_page.dart';
import 'package:budgy1/pages/edit_cat.dart';
import 'package:budgy1/pages/limit_page.dart';
import 'package:budgy1/pages/limit_set_page.dart';
import 'package:budgy1/pages/login_page.dart';
import 'package:budgy1/pages/manage_cats.dart';
import 'package:budgy1/pages/new_cat.dart';
import 'package:budgy1/pages/new_test_page.dart';
import 'package:budgy1/pages/newui.dart';
import 'package:budgy1/pages/opening_page.dart';
import 'package:budgy1/pages/profile_page.dart';
import 'package:budgy1/pages/registration_page.dart';
import 'package:budgy1/pages/test_page.dart';
import 'package:budgy1/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:budgy1/pages/home_page.dart';
import 'package:budgy1/pages/list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kdarkpurple,
          secondary: kColor3,
            
        ),
        fontFamily: GoogleFonts.andika().fontFamily,
        primaryTextTheme: GoogleFonts.andikaTextTheme(),
      ),
      
      // initialRoute: HomePage.id,
      initialRoute: LoginPage.id,
      routes: {
        // CatDetail.id:(context) => CatDetail(),
        NewCat.id:(context) => NewCat(),
        EditCat.id:(context) => EditCat(),
        ProfilePage.id:(context) => ProfilePage(),
        ManageCats.id:(context) => ManageCats(),
        LoginPage.id:(context) => LoginPage(),
        RegistrationPage.id:(context) => RegistrationPage(),
        NewUI.id:(context) => NewUI(),
        OpeningPage.id:(context) => OpeningPage(),
        NewTestPage.id:(context) => NewTestPage(),
        TestPage.id:(context) => TestPage(),
        HomePage.id:(context) => HomePage(),
        ListPage.id:(context) => ListPage(),
        AddNew.id:(context) => AddNew(),
        AveragePage.id:(context) => AveragePage(),
        LimitPage.id:(context) => LimitPage(),
        LimitSetPage.id:(context)=>LimitSetPage(),
        CategoriesPage.id:(context) => CategoriesPage(),  
      },
    );
  }
}