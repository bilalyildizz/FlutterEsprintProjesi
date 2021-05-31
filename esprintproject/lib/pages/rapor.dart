import 'dart:convert';
import 'package:esprintproject/models/gidenBakiyeModel.dart';
import 'package:esprintproject/models/gidenKategoriModel.dart';
import 'package:esprintproject/services/gidenBakiye.dart';
import 'package:esprintproject/services/gidenKategori.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:esprintproject/shared/loginShared.dart';

import 'login.dart';
import 'maliyet.dart';

class Rapor extends StatefulWidget {
  @override
  _RaporState createState() => _RaporState();
}
// Tarih aralığını doğru göstermiyor. isAfter İsBefore Çalışmıyor.
class _RaporState extends State<Rapor> {
  GidenBakiyeService gidenBakiyeService = new GidenBakiyeService();
  GidenKategoriService gidenKategoriService = new GidenKategoriService();
  List<GidenBakiyeModel> gidenBakiyeList = [];
  List<GidenKategoriModel> gidenKategoriList = [];
  List<GidenBakiyeModel> bastirList = [];
  List<GidenBakiyeModel> tersbastirList = [];
  int toplamMaliyet =0;

  DateTime baslangicT = DateTime.now();
  DateTime bitisT = DateTime.now();

  bool showWidget = false;

  @override
  void initState() {
    super.initState();
  }

  //ListeDoldurBakiye
  bakiyeListeDoldur() async {
    await gidenBakiyeService.getGidenBakiye().then((liste) {
      gidenBakiyeList = liste;
    });
  }

  kategoriListeDoldur() async {
    await gidenKategoriService.getGidenKategori().then((liste) {
      gidenKategoriList = liste;
    });
  }

// Date
  Future<void> _baslangicTarihi(BuildContext context) async {
    final dynamic picked = await showDatePicker(
        context: context,
        initialDate: baslangicT,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != baslangicT)
      setState(() {
        baslangicT = picked;
      });
  }

//Date
  Future<void> _bitisTarihi(BuildContext context) async {
    final dynamic picked = await showDatePicker(
        context: context,
        initialDate: bitisT,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != bitisT)
      setState(() {
        bitisT = picked;
      });
  }

  bastirilicakListeOlustur(){
   bastirList.clear();
   toplamMaliyet=0;
    for(int i=0;i<gidenBakiyeList.length;i++){
      for(int j=0;j<gidenKategoriList.length;j++){
        if(gidenBakiyeList[i].kategori == gidenKategoriList[j].id){
          gidenBakiyeList[i].kategori=gidenKategoriList[j].kategoriAdi;
        }

      }
      if(gidenBakiyeList[i].createdAt.isAfter(baslangicT) && gidenBakiyeList[i].createdAt.isBefore(bitisT)){
        bastirList.add(gidenBakiyeList[i]);
        toplamMaliyet +=int.parse(gidenBakiyeList[i].giderMiktar);
    
      }

    }
    tersbastirList.clear();
    for(int i = bastirList.length-1;i>=0;i--){
      tersbastirList.add(bastirList[i]);
    }

   

  }

  addWidget() {
    setState(() {
      showWidget = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gider Rapor"),
        
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.08,
                          MediaQuery.of(context).size.height * 0.05,
                          0,
                          0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () => _baslangicTarihi(context),
                          child: Center(
                              child: Text(
                            'Başlangıç Tarihi',
                            textAlign: TextAlign.center,
                          )),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.08,
                          MediaQuery.of(context).size.height * 0.05,
                          0,
                          0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ElevatedButton(
                          onPressed: () => _bitisTarihi(context),
                          child: Center(
                              child: Text(
                            'Bitiş Tarihi',
                            textAlign: TextAlign.center,
                          )),
                        ),
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    MediaQuery.of(context).size.height * 0.04,
                    0,
                    MediaQuery.of(context).size.height * 0.04),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                    onPressed: () async {
                      await bakiyeListeDoldur();
                      await kategoriListeDoldur();
                      bastirilicakListeOlustur();
                      addWidget();
                      if(baslangicT.isBefore(bitisT)){
                        debugPrint(baslangicT.toString());
                      }
                      else{debugPrint("b");}
                    },
                    child: Center(
                        child: Text(
                      'Göster',
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
              ),
              showWidget
                  ? Column(
                      children: [
                        Table(
                          border: TableBorder.all(
                              color: Colors.blue.shade400, width: 0.8),
                          children: [
                            TableRow(children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Center(
                                  child: Text(
                                    "Gider Türü",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Center(
                                  child: Text(
                                    "Gider Açıklama",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Center(
                                  child: Text(
                                    "Gider Tutar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Center(
                                  child: Text(
                                    "Tarih",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ])
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: tersbastirList.length,
                            itemBuilder: (context, index) {
                              GidenBakiyeModel tekGider =
                                  tersbastirList[index];

                              return Table(
                                border: TableBorder.all(
                                    color: Colors.grey, width: 0.2),
                                children: [
                                  TableRow(children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Center(
                                        child: Text(
                                          tekGider.kategori,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade600,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Center(
                                        child: Text(
                                          tekGider.giderAciklama,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade600,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Center(
                                        child: Text(
                                          tekGider.giderMiktar,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade600,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: Center(
                                        child: Text(
                                          tekGider.createdAt.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade600,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ])
                                ],
                              );
                            }),
                      ],
                    )
                  : Container(),
                  showWidget ? Divider(height: MediaQuery.of(context).size.height*0.05,):Container(),
                  showWidget ? SizedBox(
                     child: Text("Toplam Maliyet:  $toplamMaliyet TL",style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold),)
                  ):Container(),
                         
             
            ],
          ),
        ),
      ),
    );
  }
}

//watch full detail video at youtube
