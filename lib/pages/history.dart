import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/pages/cmd_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var f, c, auth, str, d, p, m, a1;
var b = [];

class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  void initState() {
    b.clear();
    f = Firestore.instance;
    auth = FirebaseAuth.instance;
    c = auth.currentUser.email;

    //func();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    b.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("History"),
          centerTitle: true,
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: f.collection("users").doc(c).collection('days').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
              itemBuilder: (context, index) {
                p = snapshot.data.docs[index];

                b.add("${p.id}");

                return Container(
                  height: 50,
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    child: Text("${b[index]}"),
                    onPressed: () {
                      var a1 = b[index];
                      print("a1 is $a1");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => cmd_history(d: a1)));
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
