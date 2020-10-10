import 'dart:convert';

import 'package:flutter_pensil_app/helper/enum.dart';
class StudentResponseModel {
    StudentResponseModel({
        this.students,
    });

    final List<ActorModel> students;

    factory StudentResponseModel.fromRawJson(String str) => StudentResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StudentResponseModel.fromJson(Map<String, dynamic> json) => StudentResponseModel(
        students: json["students"] == null ? null : List<ActorModel>.from(json["students"].map((x) => ActorModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "students": students == null ? null : List<dynamic>.from(students.map((x) => x.toJson())),
    };
}
class ActorModel {
  ActorModel({
      this.name,
      this.email,
      this.password,
      this.role,
      this.mobile,
      this.token,
      this.id,
      this.isVerified,
      this.lastLoginDate,
      this.isSelected = false,
  });

  final String name;
  final String email;
  final String password;
  final String role;
  final String mobile;
  final String token;
  final bool isVerified;
  final DateTime lastLoginDate;
  final String id;
  bool isSelected;

  factory ActorModel.fromRawJson(String str) => ActorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActorModel.fromJson(Map<String, dynamic> json) => ActorModel(
    isVerified: json["isVerified"] == null ? null : json["isVerified"],
    lastLoginDate: json["lastLoginDate"] == null ? null : DateTime.parse(json["lastLoginDate"]),
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    role: json["role"] == null ? null : json["role"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    token: json["token"] == null ? null : json["token"],
  );
  
  Map<String, dynamic> toJson() => {
     "isVerified": isVerified == null ? null : isVerified,
      "lastLoginDate": lastLoginDate == null ? null : lastLoginDate.toIso8601String(),
      "id": id == null ? null : id,
      "name": name == null ? null : name,
      "email": email == null ? null : email,
      "password": password == null ? null : password,
      "role": role == null ? null : role,
      "mobile": mobile == null ? null : mobile,
      "token": token == null ? null : token,
  };

  Map<String, dynamic> toJson1() => {
      "name": name == null ? null : name,
      "mobile": mobile == null ? null : mobile,
      "isSelected":isSelected == null ? null :isSelected
  };

  factory ActorModel.fromError(Map<String,dynamic> json) => ActorModel(
     password:json.containsKey("password") ? json["password"][0] : null,
     email: json.containsKey("email") ? json["email"][0] : null,
     mobile: json.containsKey("mobile") ? json["mobile"][0] : null,
     isVerified: json.containsKey("isVerified") ? json["isVerified"][0] : null
  );

  bool get isStudent => this.role == Role.STUDENT.asString();
}
