import 'package:database_app/pages/registration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Stack(
               
                children: <Widget>[
                  
               Text("Welcome",
               style: GoogleFonts.aladin(
                 color: Colors.blue[100],
                 fontSize: 100
               ),),

                ],
             ),
             SizedBox(
               height: 50
             ),
              Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 50.0,
                color: Colors.blue,
                //shadowColor: Colors.blue[50],
                
             child: MaterialButton(
               child: Container(
                 padding: EdgeInsets.all(20),
                 child: Text("Register",
                 style: GoogleFonts.aladin(
                   fontSize: 40
                 ),),
               ),
               onPressed: (){
                 Navigator.pushNamed(context, "register");
               }
             ),
             
           ),
           SizedBox(
             height: 20,
           ),
           Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 50.0,
                color: Colors.blue,
                //shadowColor: Colors.blue[50],
                
             child: MaterialButton(
               child: Container(
                 padding: EdgeInsets.all(20),
                 child: Text("Login",
                 style: GoogleFonts.aladin(
                   fontSize: 40
                 ),),
               ),
               onPressed: (){
                 Navigator.pushNamed(context,"login");
               }
             ),
             
           ),
          
          
           ],
           
            
          ),
       ));
       }
}