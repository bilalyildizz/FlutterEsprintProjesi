// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        required this.id,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.photo,
        required this.password,
        required this.rank,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String name;
    String email;
    Null emailVerifiedAt;
    dynamic photo;
    String password;
    String rank;
    dynamic createdAt;
    dynamic updatedAt;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        photo: json["photo"],
        password: json["password"],
        rank: json["rank"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "photo": photo,
        "password": password,
        "rank": rank,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
