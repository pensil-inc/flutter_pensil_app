import 'dart:convert';
class VideosRsponseModel {
    VideosRsponseModel({
        this.videos,
    });

    final List<VideoModel> videos;

    factory VideosRsponseModel.fromRawJson(String str) => VideosRsponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VideosRsponseModel.fromJson(Map<String, dynamic> json) => VideosRsponseModel(
        videos: json["videos"] == null ? null : List<VideoModel>.from(json["videos"].map((x) => VideoModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "videos": videos == null ? null : List<dynamic>.from(videos.map((x) => x.toJson())),
    };
}
class VideoModel {
    VideoModel({
        this.id,
        this.title,
        this.description,
        this.duration,
        this.subject,
        this.url,
        this.quality,
        this.isPrivate,
        this.createdAt
    });

    final String id;
    final String title;
    final String description;
    final String duration;
    final String subject;
    final String url;
    final String quality;
    final bool isPrivate;
    final DateTime createdAt;

    factory VideoModel.fromRawJson(String str) => VideoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        title: json["title"] == null ? null : json["title"],
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null ? null : json["description"],
        duration: json["duration"] == null ? null : json["duration"],
        subject: json["subject"] == null ? null : json["subject"],
        url: json["url"] == null ? null : json["url"],
        quality: json["quality"] == null ? null : json["quality"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "duration": duration == null ? null : duration,
        "subject": subject == null ? null : subject,
        "url": url == null ? null : url,
        "quality": quality == null ? null : quality,
        "isPrivate": isPrivate == null ? null : isPrivate,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    };
}
