import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';

var visible = true;
var spin = false;
var email;
var fname;
var lname;
var password;

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
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
                        child: Text("Register Yourself!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aladin(
                                fontSize: 60, color: Colors.white)),
                      ),
                      Container(
                        width: 700,
                        height: 550,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.only(top: 30, left: 20, right: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: Colors.green[300],
                                ),
                                Text("First Name", style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: TextField(
                              onChanged: (value) => {fname = value},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: Colors.green[300],
                                ),
                                Text("Last name", style: GoogleFonts.lato())
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: TextField(
                              onChanged: (value) => {lname = value},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.email,
                                  color: Colors.green[300],
                                ),
                                Text("Email", style: GoogleFonts.lato())
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
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.email,
                                  color: Colors.green[300],
                                ),
                                Text("Password", style: GoogleFonts.lato())
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
                                      if (visible == true) {
                                        visible = false;
                                      } else {
                                        visible = true;
                                      }
                                    });
                                  },
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Material(
                            borderRadius: BorderRadius.circular(30),
                            elevation: 50.0,
                            color: Colors.green[300],
                            //shadowColor: Colors.blue[50],

                            child: MaterialButton(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Register",
                                    style: GoogleFonts.aladin(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    spin = true;
                                  });

                                  var auth = FirebaseAuth.instance;
                                  var a =
                                      await auth.createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  var f = FirebaseFirestore.instance;
                                  var firebaseUser = auth.currentUser;
                                  print(firebaseUser);
                                  await f
                                      .collection("users")
                                      .doc(firebaseUser.email)
                                      .set({"fname": fname, "lname": lname});

                                  if (a.additionalUserInfo.isNewUser) {
                                    setState(() {
                                      spin = false;
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Account created successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 15,
                                        backgroundColor: Colors.green[300],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    Navigator.pushNamed(context, "/");
                                  }
                                }),
                          ),
                        ]),
                      )
                    ],
                  ),
                )
              ]),
            )));
  }
}
