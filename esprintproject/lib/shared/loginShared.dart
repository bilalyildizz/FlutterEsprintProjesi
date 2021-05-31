import 'package:shared_preferences/shared_preferences.dart';
  
Future<void> setLogin(bool veri) async {
  final kayitAraci = await SharedPreferences.getInstance();
  await kayitAraci.setBool("login", veri);
}

Future<dynamic> getLogin() async {
  final kayitAraci = await SharedPreferences.getInstance();
  dynamic veri = kayitAraci.getBool("login");
  return veri;
}

Future<void> setLevel(String veri) async {
  final kayitAraci = await SharedPreferences.getInstance();
  await kayitAraci.setString("level", veri);
}

Future<dynamic> getLevel() async {
  final kayitAraci = await SharedPreferences.getInstance();
  dynamic veri = kayitAraci.getString("level");
  return veri;
}