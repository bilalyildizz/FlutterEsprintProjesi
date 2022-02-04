import 'package:esprintproject/models/gidenKategoriModel.dart';
import 'package:esprintproject/models/maliyet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GidenKategoriService{
  static  var url= Uri.parse("http");
Future<List<GidenKategoriModel>> getGidenKategori()async{
 // static Future<List<Isler>> getTable()async{

    try{
      final  response = await http.post(url, body: {'tablo_adi': 'giden_kategori'});
      if(response.statusCode==200){
      final List<GidenKategoriModel> maliyetList = gidenKategoriModelFromJson(response.body);
        return maliyetList;
      }
      else throw Exception("Bağlantı Hatası");
    
    }
    catch(e){
          throw Exception("Bağlantı Hatası ${e}");
    }
  } 

}
