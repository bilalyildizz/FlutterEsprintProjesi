import 'package:esprintproject/models/gelenBakiyeModel.dart';
import 'package:esprintproject/models/islerModel.dart';
import 'package:esprintproject/models/musteriler.dart';
import 'package:esprintproject/services/gelenBakiye.dart';
import 'package:esprintproject/services/islerHttp.dart';
import 'package:esprintproject/services/musterilerHttp.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class GelenBakiye extends StatefulWidget {
  @override
  _GelenBakiyeState createState() => _GelenBakiyeState();
}

// Tarih aralığını doğru göstermiyor. isAfter İsBefore Çalışmıyor.
class _GelenBakiyeState extends State<GelenBakiye> {
  GelenBakiyeService gelenBakiyeService = new GelenBakiyeService();
  MusterilerService musterilerService = new MusterilerService();
  IslerService islerService = new IslerService();
  List<GelenBakiyeModel> gelenBakiyeList = [];
  List<IslerModel> islerList = [];
  List<MusterilerModel> musterilerList = [];
  List<GelenBakiyeModel> bastirList = [];
  List<GelenBakiyeModel> tersbastirList = [];
  int toplamMaliyet = 0;
  int toplamSatis =0;
  int toplamKar=0;
  

  DateTime baslangicT = DateTime.now();
  DateTime bitisT = DateTime.now();

  bool showWidget = false;

  @override
  void initState() {
    super.initState();
  }

  //ListeDoldurBakiye
  gelenBakiyeListeDoldur() async {
    await gelenBakiyeService.getGelenBakiye().then((liste) {
      gelenBakiyeList = liste;
    });
  }

  musterilerListeDoldur() async {
    await musterilerService.getMusteriler().then((liste) {
      musterilerList = liste;
    });
  }

    islerListeDoldur() async {
    await islerService.getIsler().then((liste) {
      islerList = liste;
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

  bastirilicakListeOlustur() {
    bastirList.clear();
    toplamMaliyet = 0;
    toplamSatis=0;
    toplamKar=0;
    for (int i = 0; i < gelenBakiyeList.length; i++) {
      for (int j = 0; j < musterilerList.length; j++) {
        if (gelenBakiyeList[i].musteriId == musterilerList[j].id) {
          gelenBakiyeList[i].musteriId = musterilerList[j].musteriAdi;
        }
      }
      
        for (int k = 0; k < islerList.length; k++) {
        if (gelenBakiyeList[i].isId == islerList[k].id) {
          gelenBakiyeList[i].isId = islerList[k].isBaslik;
        }
      }



      
      if (gelenBakiyeList[i].createdAt.isAfter(baslangicT) &&
          gelenBakiyeList[i].createdAt.isBefore(bitisT)) {
        bastirList.add(gelenBakiyeList[i]);
        toplamMaliyet += int.parse(gelenBakiyeList[i].maliyet);
        toplamSatis += int.parse(gelenBakiyeList[i].satis);
        

      }
    }
    toplamKar=toplamSatis-toplamMaliyet;
    tersbastirList.clear();
    for (int i = bastirList.length - 1; i >= 0; i--) {
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
        title: Text("Gelir Rapor"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                      await gelenBakiyeListeDoldur();
                      await musterilerListeDoldur();
                      await islerListeDoldur();
                      bastirilicakListeOlustur();
                      addWidget();
                      if (baslangicT.isBefore(bitisT)) {
                        debugPrint(baslangicT.toString());
                      } else {
                        debugPrint("b");
                      }
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
                                    "Müşteri Adı",
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
                                    "İş Adı",
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
                                    "Maliyet",
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
                                    "Satış",
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
                                    "Kar",
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
                              GelenBakiyeModel tekGelir = tersbastirList[index];
                              int kar = int.parse(tekGelir.satis)-int.parse(tekGelir.maliyet);
                              String convertedDate = new DateFormat("dd-MM-yyyy").format(tekGelir.createdAt);
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
                                          tekGelir.musteriId,
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
                                          tekGelir.isId,
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
                                          tekGelir.maliyet+ " TL",
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
                                          tekGelir.satis+" TL",
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
                                         " $kar TL",
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
                                          convertedDate.toString(),
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
              showWidget
                  ? Divider(
                      height: MediaQuery.of(context).size.height * 0.05,
                    )
                  : Container(),
              showWidget
                  ?Column(children: [
                    SizedBox(
                      child: Text(
                      "Toplam Maliyet:  $toplamMaliyet TL",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      child: Text(
                      "Toplam SATIŞ:  $toplamSatis TL",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30),child:
                    SizedBox(
                      child: Text(
                      "Toplam KAR:  $toplamKar TL",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
                  ],) 
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

//watch full detail video at youtube
