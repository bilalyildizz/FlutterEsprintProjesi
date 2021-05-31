import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class IkiSayfa extends StatefulWidget {
  @override
  _IkiSayfaState createState() => _IkiSayfaState();
}

class _IkiSayfaState extends State<IkiSayfa> {

  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("2.sayfa"),
      ),
      body: Center(
        child: Text("Kullanıcı Girişi"),
      ),
    );
  
  }
}

//watch full detail video at youtube
