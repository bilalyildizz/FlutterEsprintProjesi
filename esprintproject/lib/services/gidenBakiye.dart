import 'package:esprintproject/models/gidenBakiyeModel.dart';
import 'package:esprintproject/models/maliyet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GidenBakiyeService{
  static  var url= Uri.parse("http");
Future<List<GidenBakiyeModel>> getGidenBakiye()async{
 // static Future<List<Isler>> getTable()async{

    try{
      final  response = await http.post(url, body: {'tablo_adi': 'giden_bakiye'});
      if(response.statusCode==200){
      final List<GidenBakiyeModel> gidenBakiyeList = gidenBakiyeModelFromJson(response.body);
        return gidenBakiyeList;
      }
      else throw Exception("Bağlantı Hatası");
    
    }
    catch(e){
          throw Exception("Bağlantı Hatası ${e}");
    }
  } 

}
