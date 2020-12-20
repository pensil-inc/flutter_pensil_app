import 'dart:convert';

class VideosRsponseModel {
  VideosRsponseModel({
    this.videos,
  });

  final List<VideoModel> videos;

  factory VideosRsponseModel.fromRawJson(String str) =>
      VideosRsponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideosRsponseModel.fromJson(Map<String, dynamic> json) =>
      VideosRsponseModel(
        videos: json["videos"] == null
            ? null
            : List<VideoModel>.from(
                json["videos"].map((x) => VideoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "videos": videos == null
            ? null
            : List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class VideoModel {
  VideoModel({
    this.id,
    this.batch,
    this.title,
    this.subject,
    this.description,
    this.duration,
    this.thumbnailUrl,
    this.videoUrl,
    this.video,
    this.isPrivate,
    this.quality,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String batch;
  final String title;
  final String subject;
  final String description;
  final String duration;
  final String thumbnailUrl;
  final String videoUrl;
  final String video;
  final bool isPrivate;
  final String quality;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory VideoModel.fromRawJson(String str) =>
      VideoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"] == null ? null : json["id"],
        batch: json["batch"] == null ? null : json["batch"],
        title: json["title"] == null ? null : json["title"],
        subject: json["subject"] == null ? null : json["subject"],
        description: json["description"] == null ? null : json["description"],
        duration: json["duration"] == null ? null : json["duration"],
        thumbnailUrl:
            json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
        videoUrl: json["videoUrl"] == null ? null : json["videoUrl"],
        video: json["video"] == null ? null : json["video"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
        quality: json["quality"] == null ? null : json["quality"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "batch": batch == null ? null : batch,
        "title": title == null ? null : title,
        "subject": subject == null ? null : subject,
        "description": description == null ? null : description,
        "duration": duration == null ? null : duration,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
        "videoUrl": videoUrl == null ? null : videoUrl,
        "video": video == null ? null : video,
        "isPrivate": isPrivate == null ? null : isPrivate,
        "quality": quality == null ? null : quality,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  VideoModel copyWith({
    String id,
    String title,
    String subject,
    String batch,
    String description,
    String duration,
    String video,
    DateTime fileUploadedOn,
    bool isPrivate,
    String quality,
    DateTime createdAt,
    DateTime updatedAt,
    String videoUrl,
    String thumbnailUrl,
  }) =>
      VideoModel(
        id: id ?? this.id,
        batch: batch ?? this.batch,
        title: title ?? this.title,
        subject: subject ?? this.subject,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        video: video ?? this.video,
        isPrivate: isPrivate ?? this.isPrivate,
        quality: quality ?? this.quality,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        videoUrl: videoUrl ?? this.videoUrl,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );
}
