// To parse this JSON data, do
//
//     final gelenBakiyeModel = gelenBakiyeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<GelenBakiyeModel> gelenBakiyeModelFromJson(String str) => List<GelenBakiyeModel>.from(json.decode(str).map((x) => GelenBakiyeModel.fromJson(x)));

String gelenBakiyeModelToJson(List<GelenBakiyeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GelenBakiyeModel {
    GelenBakiyeModel({
        required this.id,
        required this.musteriId,
        required this.isId,
        required this.maliyet,
        required this.satis,
        required this.gelenBakiye,
        required this.createdAt,
        required this.updatedAt,
        required this.isResmi,
    });

    String id;
    String musteriId;
    String isId;
    String maliyet;
    String satis;
    dynamic gelenBakiye;
    DateTime createdAt;
    DateTime updatedAt;
    String isResmi;

    factory GelenBakiyeModel.fromJson(Map<String, dynamic> json) => GelenBakiyeModel(
        id: json["id"],
        musteriId: json["musteri_id"],
        isId: json["is_id"],
        maliyet: json["maliyet"],
        satis: json["satis"],
        gelenBakiye: json["gelen_bakiye"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isResmi: json["isResmi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "musteri_id": musteriId,
        "is_id": isId,
        "maliyet": maliyet,
        "satis": satis,
        "gelen_bakiye": gelenBakiye,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt.toIso8601String(),
        "isResmi": isResmi,
    };
}
