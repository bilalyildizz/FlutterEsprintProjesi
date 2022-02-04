import 'package:esprintproject/models/gelenBakiyeModel.dart';
import 'package:esprintproject/models/gidenBakiyeModel.dart';
import 'package:esprintproject/models/islerModel.dart';
import 'package:esprintproject/models/maliyet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class IslerService{
  static  var url= Uri.parse("http");
Future<List<IslerModel>> getIsler()async{
 // static Future<List<Isler>> getTable()async{

    try{
      final  response = await http.post(url, body: {'tablo_adi': 'isler'});
      if(response.statusCode==200){
     final List<IslerModel> islerList = islerModelFromJson(response.body);
        return islerList;
      }
      else throw Exception("Bağlantı Hatası");
    
    }
    catch(e){
          throw Exception("Bağlantı Hatası ${e}");
    }
  } 

}
