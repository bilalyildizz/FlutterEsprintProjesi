import 'package:crypto/crypto.dart';
import 'package:esprintproject/models/users.dart';
import 'package:esprintproject/pages/sayfa1.dart';
import 'package:esprintproject/pages/sayfa2.dart';
import 'package:esprintproject/services/loginHttp.dart';
import 'package:esprintproject/services/maliyetHttp.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:esprintproject/shared/loginShared.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// iki kere doğru giriş yapunca kontrol true oluyor ve gitmesi gereken sayfaya gidiyor.
//maliyet sayfasında tablo başlıkları ekrana sabitlenmeli.
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          scaffoldBackgroundColor: Colors.black87,
          appBarTheme: AppBarTheme(backgroundColor: Colors.lightBlue.shade900)),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  MaliyetService maliyetService = new MaliyetService();
  UserService usersService = new UserService();
  List<UserModel> userList = [];
  bool kontrolSonucu = false;
  String kullaniciYetkisi = "normal";

  @override
  void initState() {
    super.initState();
    //deneme();
  }

  void deneme() async {
    if (await getLogin() != null) {
      if (await getLogin() == true) {
        if (await getLevel() == "1")
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BirSayfa()),
          );
        else
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IkiSayfa()),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    maliyetService.getMaliyet();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.15,
                    MediaQuery.of(context).size.height * 0.2,
                    MediaQuery.of(context).size.width * 0.15,
                    1),
                child: Image.asset("assets/logo.png",
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.2),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.15,
                    MediaQuery.of(context).size.height * 0.1,
                    MediaQuery.of(context).size.width * 0.15,
                    1),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: userController,
                  decoration: InputDecoration(
                    hintText: "Kullanıcı Adı",
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.blue.shade400, width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue.shade400)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.15,
                    MediaQuery.of(context).size.height * 0.08,
                    MediaQuery.of(context).size.width * 0.15,
                    1),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: "Şifre",
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.blue.shade400, width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue.shade400)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.5,
                    MediaQuery.of(context).size.height * 0.06,
                    MediaQuery.of(context).size.width * 0.15,
                    1),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: MediaQuery.of(context).size.width * 0.28,
                        height: MediaQuery.of(context).size.width * 0.12),
                    child: ElevatedButton(
                      onPressed: () async {
                        await girisKontrol(
                            userController.text, passController.text);
                        if (kontrolSonucu == true) {
                          debugPrint("Giriş Başarılı");
                          await setLogin(true);
                          if (await getLevel() == "1")
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BirSayfa()),
                            );
                          else
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IkiSayfa()),
                            );
                        } else {
                          debugPrint("İsim veya Şifre Yanlış");
                          await setLogin(false);
                          await showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                              backgroundColor: Colors.blueAccent,
                              title: new Text('Hata',style:TextStyle(color: Colors.red),),
                              content: Text('Kullanıcı Adı Veya Şifreli Hatalı',style:TextStyle(color: Colors.white)),
                              actions: <Widget>[
                                new TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(); // dismisses only the dialog and returns nothing
                                  },
                                  child: new Text('OK',style:TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Giriş",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade400),
                      ),
                    )),
              ),
            ],
          ),
        )),
      ),
    );
  }

  girisKontrol(String username, String password) async {
    String passwordMd5 = generateMd5(password);
    await usersService.getUsers().then((eskiListe) {
      userList = eskiListe;
    });

    for (int i = 0; i < userList.length; i++) {
      if (userList[i].email == username &&
          userList[i].password == passwordMd5) {
        kontrolSonucu = true;

        await setLevel(userList[i].rank);
      }
    }
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
