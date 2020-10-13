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
    this.batchId,
    this.title,
    this.subject,
    this.description,
    this.duration,
    this.thumbnailUrl,
    this.videoUrl,
    this.isPrivate,
    this.quality,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String batchId;
  final String title;
  final String subject;
  final String description;
  final String duration;
  final String thumbnailUrl;
  final String videoUrl;
  final bool isPrivate;
  final String quality;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory VideoModel.fromRawJson(String str) => VideoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"] == null ? null : json["id"],
        batchId: json["batchId"] == null ? null : json["batchId"],
        title: json["title"] == null ? null : json["title"],
        subject: json["subject"] == null ? null : json["subject"],
        description: json["description"] == null ? null : json["description"],
        duration: json["duration"] == null ? null : json["duration"],
        thumbnailUrl: json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
        videoUrl: json["videoUrl"] == null ? null : json["videoUrl"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
        quality: json["quality"] == null ? null : json["quality"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "batchId": batchId == null ? null : batchId,
        "title": title == null ? null : title,
        "subject": subject == null ? null : subject,
        "description": description == null ? null : description,
        "duration": duration == null ? null : duration,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
        "videoUrl": videoUrl == null ? null : videoUrl,
        "isPrivate": isPrivate == null ? null : isPrivate,
        "quality": quality == null ? null : quality,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
