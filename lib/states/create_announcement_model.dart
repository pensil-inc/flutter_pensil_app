import 'dart:convert';

class CreateAnnouncementModel {
    CreateAnnouncementModel({
        this.title,
        this.description,
        this.isForAll,
        this.batches,
    });

    final String description;
    final String title;
    final bool isForAll;
    final List<String> batches;

    factory CreateAnnouncementModel.fromRawJson(String str) => CreateAnnouncementModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CreateAnnouncementModel.fromJson(Map<String, dynamic> json) => CreateAnnouncementModel(
        description: json["description"] == null ? null : json["description"],
        title: json["title"] == null ? null : json["title"],
        isForAll: json["isForAll"] == null ? null : json["isForAll"],
        batches: json["batches"] == null ? null : List<String>.from(json["batches"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "isForAll": isForAll == null ? null : isForAll,
        "batches": batches == null ? null : List<dynamic>.from(batches.map((x) => x)),
    };
}
