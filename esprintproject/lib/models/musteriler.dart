// To parse this JSON data, do
//
//     final musterilerModel = musterilerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MusterilerModel> musterilerModelFromJson(String str) => List<MusterilerModel>.from(json.decode(str).map((x) => MusterilerModel.fromJson(x)));

String musterilerModelToJson(List<MusterilerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MusterilerModel {
    MusterilerModel({
        required this.id,
        required this.musteriAdi,
        required this.vergiNo,
        required this.vergiDaire,
        required this.adres,
        required this.telefon,
        required this.mail,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String musteriAdi;
    String vergiNo;
    dynamic vergiDaire;
    dynamic adres;
    dynamic telefon;
    dynamic mail;
    DateTime createdAt;
    String updatedAt;

    factory MusterilerModel.fromJson(Map<String, dynamic> json) => MusterilerModel(
        id: json["id"],
        musteriAdi: json["musteri_adi"],
        vergiNo: json["vergi_no"],
        vergiDaire: json["vergi_daire"],
        adres: json["adres"],
        telefon: json["telefon"],
        mail: json["mail"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "musteri_adi": musteriAdi,
        "vergi_no": vergiNo,
        "vergi_daire": vergiDaire,
        "adres": adres,
        "telefon": telefon,
        "mail": mail,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
    };
}
