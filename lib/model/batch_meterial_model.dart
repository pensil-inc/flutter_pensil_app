import 'dart:convert';

class BatchMaterialRespopnseModel {
  BatchMaterialRespopnseModel({
    this.materials,
  });

  final List<BatchMaterialModel> materials;

  BatchMaterialRespopnseModel copyWith({
    List<BatchMaterialModel> materials,
  }) =>
      BatchMaterialRespopnseModel(
        materials: materials ?? this.materials,
      );

  factory BatchMaterialRespopnseModel.fromRawJson(String str) =>
      BatchMaterialRespopnseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BatchMaterialRespopnseModel.fromJson(Map<String, dynamic> json) =>
      BatchMaterialRespopnseModel(
        materials: json["materials"] == null
            ? null
            : List<BatchMaterialModel>.from(
                json["materials"].map((x) => BatchMaterialModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "materials": materials == null
            ? null
            : List<dynamic>.from(materials.map((x) => x.toJson())),
      };
}

class BatchMaterialModel {
  BatchMaterialModel({
    this.id,
    this.articleUrl,
    this.title,
    this.subject,
    this.description,
    this.batchId,
    this.file,
    this.fileType,
    this.isPrivate,
    this.fileUploadedOn,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String articleUrl;
  final String title;
  final String subject;
  final String description;
  final String batchId;
  final String file;
  final String fileType;
  final bool isPrivate;
  final String fileUploadedOn;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory BatchMaterialModel.fromRawJson(String str) =>
      BatchMaterialModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BatchMaterialModel.fromJson(Map<String, dynamic> json) =>
      BatchMaterialModel(
        id: json["id"] == null ? null : json["id"],
        articleUrl: json["fileUrl"] == null ? null : json["fileUrl"],
        title: json["title"] == null ? null : json["title"],
        subject: json["subject"] == null ? null : json["subject"],
        description: json["description"] == null ? null : json["description"],
        batchId: json["batchId"] == null ? null : json["batchId"],
        file: json["file"] == null ? null : json["file"],
        fileType: json["file"] == null
            ? null
            : json["file"].split("/").last.split(".").last,
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
        fileUploadedOn:
            json["fileUploadedOn"] == null ? null : json["fileUploadedOn"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "fileUrl": articleUrl == null ? null : articleUrl,
        "title": title == null ? null : title,
        "subject": subject == null ? null : subject,
        "description": description == null ? null : description,
        "batchId": batchId == null ? null : batchId,
        "file": file == null ? null : file,
        "fileType": fileType == null ? null : fileType,
        "isPrivate": isPrivate == null ? null : isPrivate,
        "fileUploadedOn": fileUploadedOn == null ? null : fileUploadedOn,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  BatchMaterialModel copyWith({
    String id,
    String articleUrl,
    String title,
    String subject,
    String description,
    String batchId,
    String file,
    String fileType,
    String isPrivate,
    String fileUploade,
    String createdAt,
    String updatedAt,
  }) {
    return BatchMaterialModel(
      articleUrl: articleUrl ?? this.articleUrl,
      batchId: batchId ?? this.batchId,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      file: file ?? this.file,
      fileType: fileType ?? this.fileType,
      fileUploadedOn: fileUploadedOn ?? this.fileUploadedOn,
      id: id ?? this.id,
      isPrivate: isPrivate ?? this.isPrivate,
      subject: subject ?? this.subject,
      title: title ?? this.title,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
