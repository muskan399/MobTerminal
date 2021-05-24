import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

var visible = true;
var spin = false;
var email;
var password;
var auth = FirebaseApp.instance;

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color.fromRGBO(29, 92, 128, 1),
            body: ModalProgressHUD(
              inAsyncCall: spin,
              child:
                  ListView(padding: const EdgeInsets.all(8), children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 60, left: 30, right: 30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Text("Login",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 60,
                                color: Colors.white)),
                      ),
                      Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30, left: 20, right: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.email, color: Colors.black),
                              Text("Email",
                                  style: GoogleFonts.lato(fontSize: 20))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: TextField(
                            onChanged: (value) => {email = value},
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              Text("Password",
                                  style: GoogleFonts.lato(fontSize: 20))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: TextField(
                            onChanged: (value) => {password = value},
                            obscureText: visible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: visible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    print(visible);
                                    if (visible == true) {
                                      visible = false;
                                    } else {
                                      visible = true;
                                    }
                                    print("Visible is $visible");
                                  });
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Material(
                          borderRadius: BorderRadius.circular(30),
                          elevation: 50.0,
                          color: Colors.black,
                          //shadowColor: Colors.blue[50],

                          child: MaterialButton(
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.aladin(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                print(email);
                                setState(() {
                                  spin = true;
                                });

                                var auth = FirebaseAuth.instance;
                                var a = await auth.signInWithEmailAndPassword(
                                    email: email, password: password);

                                if (a != null) {
                                  setState(() {
                                    spin = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Successful Signin!!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 15,
                                      backgroundColor: Colors.green[300],
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.pushNamed(context, "welcome");
                                }
                              }),
                        ),
                        Container(
                          //color: Colors.black,

                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Don't have an account?",
                                style: GoogleFonts.lato(
                                    fontSize: 20, color: Colors.white),
                              ),
                              FlatButton(
                                child: Text(
                                  "SignUp",
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, "register"),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            children: <Widget>[
                              Text("Login via",
                                  style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Image.network(
                                    "https://raw.githubusercontent.com/muskan399/first/master/linkedin.png"),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Image.network(
                                    "https://raw.githubusercontent.com/muskan399/first/master/fb.png"),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )
                      ]),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
