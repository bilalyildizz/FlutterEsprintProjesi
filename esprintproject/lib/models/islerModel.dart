// To parse this JSON data, do
//
//     final islerModel = islerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<IslerModel> islerModelFromJson(String str) => List<IslerModel>.from(json.decode(str).map((x) => IslerModel.fromJson(x)));

String islerModelToJson(List<IslerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IslerModel {
    IslerModel({
        required this.id,
        required this.musteriId,
        required this.createdAt,
        required this.updatedAt,
        required this.isBaslik,
        required this.isAciklama,
        required this.isDurumu,
        required this.isYukumluluk,
        required this.isSorumlusu,
        required this.isAdet,
        required this.isPaketleme,
        required this.isTeslim,
        required this.isActive,
    });

    String id;
    String musteriId;
    DateTime createdAt;
    DateTime updatedAt;
    String isBaslik;
    String isAciklama;
    String isDurumu;
    dynamic isYukumluluk;
    dynamic isSorumlusu;
    String isAdet;
    String isPaketleme;
    String isTeslim;
    String isActive;

    factory IslerModel.fromJson(Map<String, dynamic> json) => IslerModel(
        id: json["id"],
        musteriId: json["musteri_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isBaslik: json["is_baslik"],
        isAciklama: json["is_aciklama"],
        isDurumu: json["is_durumu"],
        isYukumluluk: json["is_yukumluluk"],
        isSorumlusu: json["is_sorumlusu"],
        isAdet: json["is_adet"],
        isPaketleme: json["is_paketleme"],
        isTeslim: json["is_teslim"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "musteri_id": musteriId,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at": "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
        "is_baslik": isBaslik,
        "is_aciklama": isAciklama,
        "is_durumu": isDurumu,
        "is_yukumluluk": isYukumluluk,
        "is_sorumlusu": isSorumlusu,
        "is_adet": isAdet,
        "is_paketleme": isPaketleme,
        "is_teslim": isTeslim,
        "isActive": isActive,
    };
}
