import 'dart:convert';

import 'package:flutter_pensil_app/model/batch_time_slot_model.dart';

class BatchModel {
    BatchModel({
        this.name,
        this.description,
        this.classes,
        this.subject,
        this.students,
    });

    final String name;
    final String description;
    final List<BatchTimeSlotModel> classes;
    final String subject;
    final List<String> students;

    factory BatchModel.fromRawJson(String str) => BatchModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BatchModel.fromJson(Map<String, dynamic> json) => BatchModel(
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        classes: json["classes"] == null ? null : List<BatchTimeSlotModel>.from(json["classes"].map((x) => BatchTimeSlotModel.fromJson(x))),
        subject: json["subject"] == null ? null : json["subject"],
        students: json["students"] == null ? null : List<String>.from(json["students"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "classes": classes == null ? null : List<dynamic>.from(classes.map((x) => x.toJson()),),
        "subject": subject == null ? null : subject,
        "students": students == null ? null : List<String>.from(students.map((x) => x),)
    };

    
}
