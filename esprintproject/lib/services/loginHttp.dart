import 'dart:convert';
import 'package:esprintproject/models/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*
class HttpUser{



var response  =await http.post(Uri.parse("http"),body: {
  "tablo_adi": "isler"
});
    debugPrint(response.body);
  
  return response.body;
  
}
}
*/


class UserService{
  static  var url= Uri.parse("http");
Future<List<UserModel>> getUsers()async{
 // static Future<List<Isler>> getTable()async{

    try{
      final  response = await http.post(url, body: {'tablo_adi': 'users'});
      if(response.statusCode==200){
        
      final List<UserModel> tabloList = userModelFromJson(response.body);
        return tabloList;
      }
      else throw Exception("Bağlantı Hatası");
    
    }
    catch(e){
          throw Exception("Bağlantı Hatası ${e}");
    }
  } 

}
