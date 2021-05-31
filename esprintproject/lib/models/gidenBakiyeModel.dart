// To parse this JSON data, do
//
//     final gidenBakiyeModel = gidenBakiyeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GidenBakiyeModel> gidenBakiyeModelFromJson(String str) => List<GidenBakiyeModel>.from(json.decode(str).map((x) => GidenBakiyeModel.fromJson(x)));

String gidenBakiyeModelToJson(List<GidenBakiyeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GidenBakiyeModel {
    GidenBakiyeModel({
        required this.id,
        required this.kategori,
        required this.giderAciklama,
        required this.giderMiktar,
        required this.createdAt,
    });

    String id;
    String kategori;
    String giderAciklama;
    String giderMiktar;
    DateTime createdAt;

    factory GidenBakiyeModel.fromJson(Map<String, dynamic> json) => GidenBakiyeModel(
        id: json["id"],
        kategori: json["kategori"],
        giderAciklama: json["gider_aciklama"],
        giderMiktar: json["gider_miktar"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kategori": kategori,
        "gider_aciklama": giderAciklama,
        "gider_miktar": giderMiktar,
        "created_at": createdAt.toIso8601String(),
    };
}
