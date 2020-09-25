import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/pages/terminal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

 var auth=FirebaseAuth.instance;
  var a=FirebaseFirestore.instance;
  var f=Firestore.instance;
 
  var p;
  var ip;
  var spin=true;
    var u=auth.currentUser.email;

class welcome extends StatefulWidget {
  
  
  
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
 

      func() async{
           
          
            p=await f.collection('users').doc("$u").get().then((value) => value.data()['fname']);
            return p;
        
      }
     
  @override
  Widget build(BuildContext context) {
  
  
    return Scaffold(
    
        appBar: AppBar(
      backgroundColor: Colors.black,
      elevation: 40,
      title: Text("MobTerminal", style: GoogleFonts.actor(),
      ),
      centerTitle: true,
      actions: <Widget>[IconButton(icon: Icon(Icons.ac_unit), onPressed: () async{
await auth.signOut();
          })],
      //leading: Icon(Icons.ac_unit),
       //actions: <Widget>[IconButton(icon: Icon(Icons.notifications), onPressed: null),],
       ),//
        
         
        body: Container(
          child: ListView(
            
                    
              children: <Widget>[
                
                    Container(

        width: 700,
        height: 700,
        decoration: BoxDecoration(
          
          image: DecorationImage(image: NetworkImage("https://raw.githubusercontent.com/muskan399/first/master/95150.jpg"),fit: BoxFit.cover)
        ),
        child: Container(
          alignment: Alignment.center,
        
          child: Column(

           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
           
            children: <Widget>[
              Container(
                width: 700,
                height: 150,
                margin: EdgeInsets.only(bottom: 120),
                child: FutureBuilder(builder: (context,snap){
if(snap.connectionState==ConnectionState.done)
{
  print("Done");
    return Container(child: Container(
  decoration: BoxDecoration(
    color: Colors.grey[400]
  
  ),
alignment: Alignment.center,
padding: EdgeInsets.all(40),

  child:   Text("Hello $p",
  
  style: GoogleFonts.lato(
  color: Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.bold
  
  
  
  ),
  
  ),
));
}
else
{
  return Container(
    child: Text("")
  );
}

                  },
                  future: func(),
                  ),
              ),
              
              Container(
                      margin: EdgeInsets.all(20),
                      child: TextField(keyboardType: TextInputType.number,
                      onChanged: (val){
                        ip=val;
                        print(ip);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
              isDense: true,
              hintText: "Enter the IP",
              prefixIcon: Icon(Icons.computer),
              hasFloatingPlaceholder: false,
              labelText: "Enter the IP of the system",
                      enabledBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 4.0),
            borderRadius: BorderRadius.circular(25.0),
        
          ),
      
         filled: true,
         fillColor: Colors.grey,
         counterText: "Enter only digits",
         focusColor: Colors.green
         
                      )),
              ),
              Container(
               decoration: BoxDecoration(color: Colors.black,
               borderRadius: BorderRadius.circular(100)
               ),
                        
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.15,
                      padding: EdgeInsets.all(3),
                       
                          child: 
                              FlatButton(
                               child: Container(child: Text("Get Started!!", style: GoogleFonts.adventPro(fontSize: 40, color: Colors.white),),
                                alignment: Alignment.center,),
                                onPressed: ()async{

                                  print(ip);
                               Navigator.pushNamed(context, "terminal");
                               await f.collection('users').doc(u).set({
                                 "IP": ip,
                                
                               },
                               SetOptions(merge: true)
                               );

            
                                }
                              ),
                          
                            
                          
                        ),
                      
            ],
            
          ),
        )),
                  ],
                ),
              
                ),
            
                      
          
        
        
      
    
    );
  }
}



