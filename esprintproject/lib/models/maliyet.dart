// To parse this JSON data, do
//
//     final maliyetModel = maliyetModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MaliyetModel> maliyetModelFromJson(String str) => List<MaliyetModel>.from(json.decode(str).map((x) => MaliyetModel.fromJson(x)));

String maliyetModelToJson(List<MaliyetModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaliyetModel {
    MaliyetModel({
        required this.id,
        required this.urunAdi,
        required this.urunFiyati,
        required this.urunTarih,
    });

    dynamic id;
    dynamic urunAdi;
    dynamic urunFiyati;
    DateTime urunTarih;

    factory MaliyetModel.fromJson(Map<String, dynamic> json) => MaliyetModel(
        id: json["id"],
        urunAdi: json["urun_adi"],
        urunFiyati: json["urun_fiyati"],
        urunTarih: DateTime.parse(json["urun_tarih"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "urun_adi": urunAdi,
        "urun_fiyati": urunFiyati,
        "urun_tarih": "${urunTarih.year.toString().padLeft(4, '0')}-${urunTarih.month.toString().padLeft(2, '0')}-${urunTarih.day.toString().padLeft(2, '0')}",
    };
}
