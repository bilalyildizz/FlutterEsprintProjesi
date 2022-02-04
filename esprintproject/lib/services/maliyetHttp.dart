import 'package:esprintproject/models/maliyet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MaliyetService{
  static  var url= Uri.parse("http");
Future<List<MaliyetModel>> getMaliyet()async{
 // static Future<List<Isler>> getTable()async{

    try{
      final  response = await http.post(url, body: {'tablo_adi': 'maliyet_liste'});
      if(response.statusCode==200){
        
      final List<MaliyetModel> maliyetList = maliyetModelFromJson(response.body);
        return maliyetList;
      }
      else throw Exception("Bağlantı Hatası");
    
    }
    catch(e){
          throw Exception("Bağlantı Hatası ${e}");
    }
  } 

}
