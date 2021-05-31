import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
 String token1="";

  @override
  void initState() {
    super.initState();
    
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
     _firebaseMessaging.getToken().then((token) {
       print("token is : " + token.toString());
       token1=token.toString();
       setState(() {
         
       });
            });
     
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           ElevatedButton(onPressed: getQue,child: Text("Buton"),)
          ],
        ),
      ),
    );
  }
  Future getQue() async {
  var a= "https://esprintproject.000webhostapp.com/a.php";
    if(token1 != null){
       var response  =await http.post(Uri.parse(a),
       
       body:{"token":token1}
       );
       
       
    }
    else{
      print("Token is null");
    }
  }
}

//watch full detail video at youtube
