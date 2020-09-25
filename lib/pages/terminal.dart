import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/pages/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:database_app/pages/welcome.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
  var i=1,m=1;
  var command;
  var k,ip;
  var box=new List();
  var v=new List();
  var basename=new List();
  var user=new List();
  var f=FirebaseFirestore.instance;
   var auth=FirebaseAuth.instance;
   var u = auth.currentUser.email;

  func() async{
    final DateTime now = DateTime. now();
    print(now.toUtc());
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter. format(now);
  
    
    String t=now.toIso8601String();
    
                      await f.collection("users").doc(u).collection("days").doc(formatted+" "+t).set(
                      
                         {
                           "command-output": box,
                           "dir_name":basename,
                           "user_name": user,
                           "command": v
                         },
                          SetOptions(
                        merge: true
                      )
                       );        
                      
  }
  
class terminal extends StatefulWidget {

 
 
  @override
  _terminalState createState() => _terminalState();
  
 
}

class _terminalState extends State<terminal> {
 
  @override
  void initState() {
    i=1;
    m=1;
  
  box=new List();
  basename=new List();
  user=new List();
  v=new List();
    
             super.initState();    

             setState(() {
               u=auth.currentUser.email;
             });                                                              
    }
    @override
  void dispose() {
    
    // TODO: implement dispose
    super.dispose();
  }
   

  @override
  Widget build(BuildContext context) {
    print("Email is $u");
      final DateTime now = DateTime. now();
    print(now.microsecond);
 
    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
        backgroundColor: Colors.blue[100],
      
      body: FutureBuilder<DocumentSnapshot>(builder: (context,snap){
        return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40,bottom: 20),
                child: Text("Terminal",style: GoogleFonts.lato(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                  
                ),),
              ),
        
              Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                
                  child: ListView.builder(itemBuilder: (context,index){
                    k="root";

               
return  Container(
    child: Column(      
                    crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                       //   color:Colors.black,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    child: 
                                                    Text(k,
                                                    style: GoogleFonts.lato(
                                                      fontSize: 20,
                                                      color: Colors.white
                                                    ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 20),
                                                    height: 53,
                                                    width: 100,
                                                   
                                                    child: TextField(
                                                      style: GoogleFonts.lato(fontSize: 20,
                                                      color: Colors.white
                                                      ),
                                                      
                                                      decoration: InputDecoration(
                                                      filled: true,
                                                      hoverColor: Colors.white,
                                                        focusColor: Colors.white
                                                      ),

                                                      textInputAction: TextInputAction.go,
                                                      onSubmitted: (value)async{
                                                        v.add(value);
                                                      
                                                         // ignore: unnecessary_statements
                                                         print(value);
                                                         if(value=="exit")
                                                         {
                                                           
                                                     i=i-1;
                                                      func();
                                                         }
                                                      
                                                      
                                                        command  =value;
                                                        ip=snap.hasData?snap.data.data()['IP']:"";
                                                        print("IP is $ip");
                                                        var url="http://$ip/cgi-bin/web.py?cmd=$value";
                                                  
                                                       var a= await http.get(url);
                                                      var r=a.body;
                                                      box.add(r);
                                                      
                                            setState(() {
                                              i=i+1;
                                              
                                             
                                            });

                                                       } ),
                                                  )
                                                  
                                                ],
                                              ),
                                              
                                            ),
                                           index>box.length-1?Container():Text(box.length<1?"null":box[index],
                                           style: GoogleFonts.lato(
                                             fontSize: 20,
                                             color: Colors.white
                                           ),
                                           )

                                          ],
                                        ),
  );},
                              itemCount: i
                              
                              
  
                        ),
                                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Material(
                      elevation: 30,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),

                                          child: MaterialButton(child: Text("Session History",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold

                      ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, "history");
                      },
                      ),
                    ),
                  ),
                     Container(
                       margin: EdgeInsets.only(left: 70),
                       child: Material(
                         elevation: 30,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),

                                                child: MaterialButton(
                           child: Text("Signout",
                           style: GoogleFonts.lato(
                             fontSize: 20,
                             fontWeight: FontWeight.bold
                           ),),
                           onPressed: (){
                auth.signOut();
                Navigator.pushNamed(context, "login");


              },),
                       ),
                     )
                ],
              ),
           

              
            ]
        );

      },
      future: f.collection('users').doc("$u").get()
      )  
          
            
          
      
      
    
    
    );
  }
}