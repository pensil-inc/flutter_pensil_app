import 'dart:convert';

import 'package:flutter_pensil_app/model/actor_model.dart';

class AnnouncementListResponse {
  AnnouncementListResponse({
    this.announcements,
  });

  final List<AnnouncementModel> announcements;

  factory AnnouncementListResponse.fromRawJson(String str) =>
      AnnouncementListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnnouncementListResponse.fromJson(Map<String, dynamic> json) =>
      AnnouncementListResponse(
        announcements: json["announcements"] == null
            ? null
            : List<AnnouncementModel>.from(json["announcements"]
                .map((x) => AnnouncementModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "announcements": announcements == null
            ? null
            : List<dynamic>.from(announcements.map((x) => x.toJson())),
      };
}

class AnnouncementModel {
  AnnouncementModel(
      {this.id,
      this.title,
      this.description,
      this.isForAll,
      this.image,
      this.file,
      this.batches,
      this.createdAt,
      this.owner});
  final String id;
  final String description;
  final String title;
  final bool isForAll;
  final String image;
  final String file;
  final List<String> batches;
  final DateTime createdAt;
  final ActorModel owner;

  factory AnnouncementModel.fromRawJson(String str) =>
      AnnouncementModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null ? null : json["description"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
        file: json["file"] == null ? null : json["file"],
        isForAll: json["isForAll"] == null ? null : json["isForAll"],
        batches: json["batches"] == null
            ? null
            : List<String>.from(json["batches"].map((x) => x)),
        owner:
            json["owner"] == null ? null : ActorModel.fromJson(json["owner"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "image": image == null ? null : image,
        "file": file == null ? null : file,
        "description": description == null ? null : description,
        "isForAll": isForAll == null ? null : isForAll,
        "batches":
            batches == null ? null : List<dynamic>.from(batches.map((x) => x)),
        "owner": owner == null ? null : owner.toJson(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
      };

  AnnouncementModel copyWith({
    List<String> batches,
    String description,
    String title,
    String image,
    String file,
    bool isForAll,
    ActorModel owner,
    DateTime createdAt,
    DateTime updatedAt,
    String id,
  }) =>
      AnnouncementModel(
        batches: batches ?? this.batches,
        description: description ?? this.description,
        image: image ?? this.image,
        file: file ?? this.file,
        isForAll: isForAll ?? this.isForAll,
        owner: owner ?? this.owner,
        createdAt: createdAt ?? this.createdAt,
        title: title ?? this.title,
        id: id ?? this.id,
      );
}
