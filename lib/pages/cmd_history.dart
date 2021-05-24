import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class cmd_history extends StatelessWidget {
  final String d;
  var auth = FirebaseAuth.instance;
  var a = Firestore.instance;

  cmd_history({Key key, @required this.d}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var current = auth.currentUser.email;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Command_history"),
          centerTitle: true),
      body: FutureBuilder<DocumentSnapshot>(
          future: a
              .collection('users')
              .doc('$current')
              .collection("days")
              .doc("$d")
              .get(),
          builder: (context, snap) {
            return Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(
                      top: 50,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "History of date: $d",
                        style: GoogleFonts.lato(
                            color: Colors.blue,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Expanded(
                  child: ListView.builder(
                      itemCount:
                          snap.hasData ? snap.data.data()['command'].length : 0,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.all(20),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "${snap.data.data()['command'][index]}",
                                style: GoogleFonts.lato(color: Colors.white),
                              ),
                            ));
                      }),
                ),
              ],
            );
          }),
    );
  }
}
