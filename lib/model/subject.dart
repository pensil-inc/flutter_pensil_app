import 'dart:convert';

class SubjectReponseModel {
    SubjectReponseModel({
        this.subjects,
    });

    final List<String> subjects;

    SubjectReponseModel copyWith({
        List<String> subjects,
    }) => 
        SubjectReponseModel(
            subjects: subjects ?? this.subjects,
        );

    factory SubjectReponseModel.fromRawJson(String str) => SubjectReponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubjectReponseModel.fromJson(Map<String, dynamic> json) => SubjectReponseModel(
        subjects: json["subjects"] == null ? null : List<String>.from(json["subjects"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "subjects": subjects == null ? null : List<dynamic>.from(subjects.map((x) => x)),
    };
}


class Subject { 
  final String name;
  bool isSelected;
  final int index;

  Subject({this.name,this.index,this.isSelected = false,});
}