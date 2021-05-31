
import 'package:esprintproject/pages/karRapor.dart';
import 'package:esprintproject/pages/login.dart';
import 'package:esprintproject/pages/maliyet.dart';
import 'package:esprintproject/pages/sayfa1.dart';
import 'package:esprintproject/pages/sayfa2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
      runApp(
        MaterialApp(
          initialRoute: "/",
          routes: {
            "/": (context) => BirSayfa(), 
            "/maliyet":(context) =>Maliyet()  
                       
          },
        ),
      );
}

//watch full detail video at youtube
