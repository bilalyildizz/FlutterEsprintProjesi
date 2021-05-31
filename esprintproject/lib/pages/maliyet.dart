import 'package:esprintproject/models/maliyet.dart';
import 'package:esprintproject/services/maliyetHttp.dart';
import 'package:flutter/material.dart';


 class Maliyet extends StatefulWidget {
  @override
  _MaliyetState createState() => _MaliyetState();
}

class _MaliyetState extends State<Maliyet> {
MaliyetService maliyetService = new MaliyetService();
List<MaliyetModel> maliyetList =[];

  @override
  void initState() {
    super.initState();

    maliyetService.getMaliyet().then((liste) {

      setState(() {
        maliyetList=liste;
      });
      
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar( title: Text("Maliyet"),),

body: 
SingleChildScrollView(
  child:
  Column(
  children: [
   
    Table(
                  border: TableBorder.all(color: Colors.blue.shade400,width: 0.8),
                  children: [
                    TableRow(children: [
                      Container(width: MediaQuery.of(context).size.width*0.4,height:MediaQuery.of(context).size.height*0.1,child:Center(child:Text("Ürün Adı",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue.shade700,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),) ,),
                      Container(width: MediaQuery.of(context).size.width*0.3,height:MediaQuery.of(context).size.height*0.1,child:Center(child:Text("Ürün Fiyatı",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue.shade700,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),) ,),
                      Container(width: MediaQuery.of(context).size.width*0.3,height:MediaQuery.of(context).size.height*0.1,child:Center(child:Text("Güncelleme Tarihi",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue.shade700,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),) ,),
                    ])
                  ],
                   
                    ),
                    
    
     ListView.builder(
      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
              itemCount: maliyetList.length,
              itemBuilder: (context, index) {
                MaliyetModel tekUrun = maliyetList[index];
                
                return Table(
                  border: TableBorder.all(color: Colors.grey,width: 0.2),
                  children: [
                    TableRow(children: [
                      Container(width: MediaQuery.of(context).size.width*0.4,height:MediaQuery.of(context).size.height*0.1,child:Center(child:Text(tekUrun.urunAdi,textAlign: TextAlign.center,style: TextStyle(color: Colors.blueGrey.shade600,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),) ,),
                      Container(width: MediaQuery.of(context).size.width*0.4,height:MediaQuery.of(context).size.height*0.1,child:Center(child:Text(tekUrun.urunFiyati,textAlign: TextAlign.center,style: TextStyle(color: Colors.blueGrey.shade600,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),) ,),
                      Container(width: MediaQuery.of(context).size.width*0.3,height:MediaQuery.of(context).size.height*0.1,child:Center(child:Text(tekUrun.urunTarih.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.blueGrey.shade600,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),) ,),
                    ])
                  ],
                   
                    );
                   
              }) ,
              

  ],
 
)


)
    );
  }
}
 /**/