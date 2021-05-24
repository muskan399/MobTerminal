import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/pages/cmd_history.dart';
import 'package:database_app/pages/welcome.dart';
import 'package:database_app/pages/history.dart';
import 'package:database_app/pages/home.dart';
import 'package:database_app/pages/login.dart';
import 'package:database_app/pages/registration.dart';
import 'package:database_app/pages/terminal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(a1);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (c) => home(),
        "register": (c) => register(),
        "login": (c) => login(),
        "welcome": (c) => welcome(),
        "terminal": (c) => terminal(),
        "history": (c) => history(),
      },
    );
  }
}
