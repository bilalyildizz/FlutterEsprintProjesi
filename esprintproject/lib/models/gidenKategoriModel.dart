// To parse this JSON data, do
//
//     final gidenKategoriModel = gidenKategoriModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GidenKategoriModel> gidenKategoriModelFromJson(String str) => List<GidenKategoriModel>.from(json.decode(str).map((x) => GidenKategoriModel.fromJson(x)));

String gidenKategoriModelToJson(List<GidenKategoriModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GidenKategoriModel {
    GidenKategoriModel({
        required this.id,
        required this.kategoriAdi,
        required this.createdAt,
    });

    String id;
    String kategoriAdi;
    DateTime createdAt;

    factory GidenKategoriModel.fromJson(Map<String, dynamic> json) => GidenKategoriModel(
        id: json["id"],
        kategoriAdi: json["kategori_adi"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kategori_adi": kategoriAdi,
        "created_at": createdAt.toIso8601String(),
    };
}
