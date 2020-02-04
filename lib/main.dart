
import 'package:HomeAI/Pages/home_page/HomePage.dart';
import 'package:HomeAI/Pages/login_page/LoginPage.dart';
import 'package:HomeAI/Pages/main_page/MainPage.dart';
import 'package:HomeAI/models/appUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Services/baseAuth.dart';



/// app name  studio.kapi.homeAI.and
/// 
/// 
final Auth auth = Auth();
FirebaseUser fbUser;
AppUser appUser;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      auth.getCurrentUser().then((u) {
    if (u == null) {
      print('USER IS NULL');

    } else {
      print('USER IS NOT NULL');

    }
  });


    return MaterialApp(debugShowCheckedModeBanner: false,

      title: 'myHomeAI',
      theme: ThemeData(
          accentColor: Colors.red,
          primaryColor: Colors.blueGrey,
          primarySwatch: Colors.green
      ),
      home: appUser==null
        ? LoginPage()
        : HomePage(),

      routes: <String, WidgetBuilder> {
       // '/homePage' : (BuildContext context) => HomePage(),
       '/homePage' : (BuildContext context) => MainPage(),
        '/loginPage' : (BuildContext context) => LoginPage(),
      },
    );
  }
}
