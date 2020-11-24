import 'dart:convert';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/model/batch_time_slot_model.dart';

class BatchResponseModel {
  BatchResponseModel({
    this.batches,
  });

  final List<BatchModel> batches;

  factory BatchResponseModel.fromRawJson(String str) =>
      BatchResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BatchResponseModel.fromJson(Map<String, dynamic> json) =>
      BatchResponseModel(
        batches: json["batches"] == null
            ? null
            : List<BatchModel>.from(
                json["batches"].map((x) => BatchModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "batches": batches == null
            ? null
            : List<dynamic>.from(batches.map((x) => x.toJson())),
      };
}

class BatchModel {
  BatchModel({
    this.id,
    this.name,
    this.description,
    this.classes,
    this.subject,
    this.students,
    this.studentModel,
    this.isSelected = false,
  });

  final String id;
  final String name;
  final String description;
  final List<BatchTimeSlotModel> classes;
  final String subject;
  final List<String> students;
  final List<ActorModel> studentModel;
  bool isSelected;

  factory BatchModel.fromRawJson(String str) =>
      BatchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  BatchModel copyWith({
    String id,
    String name,
    List<BatchTimeSlotModel> classes,
    String description,
    bool isSelected,
    String subject,
    List<ActorModel> studentModel,
    List<String> students,
  }) {
    return BatchModel(
      id: id ?? this.id,
      classes: classes ?? this.classes,
      description: description ?? this.description,
      isSelected: isSelected ?? this.isSelected,
      name: name ?? this.name,
      studentModel: studentModel ?? this.studentModel,
      students: students ?? this.students,
      subject: subject ?? this.subject,
    );
  }

  factory BatchModel.fromJson(Map<String, dynamic> json) => BatchModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        classes: json["classes"] == null
            ? null
            : List<BatchTimeSlotModel>.from(
                json["classes"].map((x) => BatchTimeSlotModel.fromJson(x))),
        subject: json["subject"] == null ? null : json["subject"],
        studentModel: json["students"] == null
            ? null
            : List<ActorModel>.from(
                json["students"].map((x) => ActorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "classes": classes == null
            ? null
            : List<dynamic>.from(
                classes.map((x) => x.toJson()),
              ),
        "subject": subject == null ? null : subject,
        "students": students == null
            ? null
            : List<String>.from(
                students.map((x) => x),
              )
      };
}
