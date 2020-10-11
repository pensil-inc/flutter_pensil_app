import 'dart:convert';

class NotificationResponseModel {
    NotificationResponseModel({
        this.notifications,
    });

    final List<NotificationModel> notifications;

    factory NotificationResponseModel.fromRawJson(String str) => NotificationResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
        notifications: json["notifications"] == null ? null : List<NotificationModel>.from(json["notifications"].map((x) => NotificationModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? null : List<dynamic>.from(notifications.map((x) => x.toJson())),
    };
}

class NotificationModel {
    NotificationModel({
        this.title,
        this.createdAt,
    });

    final String title;
    final DateTime createdAt;

    factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        title: json["title"] == null ? null : json["title"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    };
}
