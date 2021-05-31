import 'dart:convert';
import 'package:esprintproject/models/islerModel.dart';
import 'package:esprintproject/models/musteriler.dart';
import 'package:esprintproject/pages/karRapor.dart';
import 'package:esprintproject/pages/rapor.dart';
import 'package:esprintproject/services/islerHttp.dart';
import 'package:esprintproject/services/musterilerHttp.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esprintproject/shared/loginShared.dart';

import 'login.dart';
import 'maliyet.dart';


class BirSayfa extends StatefulWidget {
  @override
  _BirSayfaState createState() => _BirSayfaState();
}

class _BirSayfaState extends State<BirSayfa> {
  IslerService islerService = new IslerService();
  MusterilerService musterilerService = new MusterilerService();
  List<IslerModel> islerList = [];
  List<MusterilerModel> musterilerList =[];
  List<IslerModel> tersIslerList = [];

  @override
  void initState() {
    super.initState();
    islerListeDoldur();
    musterilerListeDoldur();
    tersListeDoldur();
    
  }

   islerListeDoldur()async {
     await islerService.getIsler().then((value) {
     islerList = value;
     });
   }

     musterilerListeDoldur()async {
     await musterilerService.getMusteriler().then((value) {
     musterilerList= value;
     });
   }

   tersListeDoldur(){
     for(int i =islerList.length-1;i>=0;i--){
       if(islerList[i].isDurumu != "3")
       tersIslerList.add(islerList[i]);
     }
     debugPrint(tersIslerList.length.toString());

   }


  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      appBar: AppBar(title: Text("Güncel İşler"),),
      body:  ListView.builder(
                            
                            itemCount:  tersIslerList.length,
                            itemBuilder: (context, index) {
                              IslerModel tekIs =
                                  tersIslerList[index];
                                  debugPrint(tersIslerList.length.toString());

                              return ListTile( 
                                onTap: (){},
                                title: Text(tekIs.isBaslik,style: TextStyle(color: Colors.black),),
                                subtitle: Text(tekIs.isDurumu),


                              
                              );
                            }
      ),
    );
  
  }
  
}

//watch full detail video at youtube
/*    ElevatedButton(onPressed: () async{
          await setLogin(false);
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => GelenBakiye()),
  );
        },
        child: Text("Kar Raporu"),
        ), */