import 'package:esprintproject/models/gelenBakiyeModel.dart';
import 'package:esprintproject/models/gidenBakiyeModel.dart';
import 'package:esprintproject/models/maliyet.dart';
import 'package:esprintproject/models/musteriler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MusterilerService{
  static  var url= Uri.parse("http");
Future<List<MusterilerModel>> getMusteriler()async{
 // static Future<List<Isler>> getTable()async{

    try{
      final  response = await http.post(url, body: {'tablo_adi': 'musteriler'});
      if(response.statusCode==200){
        
      final List<MusterilerModel> musterilerList = musterilerModelFromJson(response.body);
        return musterilerList;
      }
      else throw Exception("Bağlantı Hatası");
    
    }
    catch(e){
          throw Exception("Bağlantı Hatası ${e}");
    }
  } 

}
