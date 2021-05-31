import 'package:esprintproject/models/gelenBakiyeModel.dart';
import 'package:esprintproject/models/gidenBakiyeModel.dart';
import 'package:esprintproject/models/maliyet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GelenBakiyeService{
  static  var url= Uri.parse("https://muhasebe.esprint.com.tr/deneme.php");
Future<List<GelenBakiyeModel>> getGelenBakiye()async{
 // static Future<List<Isler>> getTable()async{

    try{
      final  response = await http.post(url, body: {'tablo_adi': 'maliyet_satis'});
      if(response.statusCode==200){
      final List<GelenBakiyeModel> gelenBakiyeList = gelenBakiyeModelFromJson(response.body);
        return gelenBakiyeList;
      }
      else throw Exception("Bağlantı Hatası");
    
    }
    catch(e){
          throw Exception("Bağlantı Hatası ${e}");
    }
  } 

}