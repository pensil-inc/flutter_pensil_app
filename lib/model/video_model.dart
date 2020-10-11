import 'dart:convert';

class VideoModel {
    VideoModel({
        this.title,
        this.description,
        this.duration,
        this.subject,
        this.url,
        this.quality,
        this.isPrivate,
    });

    final String title;
    final String description;
    final String duration;
    final String subject;
    final String url;
    final String quality;
    final String isPrivate;

    factory VideoModel.fromRawJson(String str) => VideoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        duration: json["duration"] == null ? null : json["duration"],
        subject: json["subject"] == null ? null : json["subject"],
        url: json["url"] == null ? null : json["url"],
        quality: json["quality"] == null ? null : json["quality"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "duration": duration == null ? null : duration,
        "subject": subject == null ? null : subject,
        "url": url == null ? null : url,
        "quality": quality == null ? null : quality,
        "isPrivate": isPrivate == null ? null : isPrivate,
    };
}
