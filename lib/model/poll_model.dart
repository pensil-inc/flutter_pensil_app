import 'dart:convert';

import 'package:flutter_pensil_app/helper/utility.dart';

class PollResponseModel {
  PollResponseModel({
    this.polls,
  });

  final List<PollModel> polls;

  factory PollResponseModel.fromRawJson(String str) =>
      PollResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PollResponseModel.fromJson(Map<String, dynamic> json) =>
      PollResponseModel(
        polls: json["polls"] == null
            ? null
            : List<PollModel>.from(
                json["polls"].map((x) => PollModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "polls": polls == null
            ? null
            : List<dynamic>.from(polls.map((x) => x.toJson())),
      };
}

class PollModel {
  PollModel(
      {this.id,
      this.question,
      this.options,
      this.endTime,
      this.batches,
      this.isForAll,
      this.answers,
      this.totalVotes,
      this.votes,
      this.createdAt,
      this.updatedAt,
      this.selection});

  final String id;
  final String question;
  final List<String> options;
  final DateTime endTime;
  final List<dynamic> batches;
  final bool isForAll;
  final List<Answer> answers;
  final int totalVotes;
  final Map<String, double> votes;
  final DateTime createdAt;
  final DateTime updatedAt;
  MySelection selection;

  PollModel copyWith({
    String id,
    String question,
    List<String> options,
    DateTime endTime,
    List<dynamic> batches,
    bool isForAll,
    List<dynamic> answers,
    int totalVotes,
    Map<String, double> votes,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      PollModel(
        id: id ?? this.id,
        question: question ?? this.question,
        options: options ?? this.options,
        endTime: endTime ?? this.endTime,
        batches: batches ?? this.batches,
        isForAll: isForAll ?? this.isForAll,
        answers: answers ?? this.answers,
        totalVotes: totalVotes ?? this.totalVotes,
        votes: votes ?? this.votes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PollModel.fromRawJson(String str) =>
      PollModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PollModel.fromJson(Map<String, dynamic> json) => PollModel(
      id: json["id"] == null ? null : json["id"],
      question: json["question"] == null ? null : json["question"],
      totalVotes: json["totalVotes"] == null ? null : json["totalVotes"],
      options: json["options"] == null
          ? null
          : List<String>.from(json["options"].map((x) => x)),
      endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
      batches: json["batches"] == null
          ? null
          : List<dynamic>.from(json["batches"].map((x) => x)),
      isForAll: json["isForAll"] == null ? null : json["isForAll"],
      answers: json["answers"] == null
          ? null
          : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      votes: json["votes"] == null
          ? null
          : Map.from(json["votes"]).map((k, v) =>
              MapEntry<String, double>(k, double.parse(v.toString()))),
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      selection: MySelection());

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "question": question == null ? null : question,
        "options":
            options == null ? null : List<dynamic>.from(options.map((x) => x)),
        "endTime": endTime == null ? null : Utility.toformattedDate3(endTime),
        "batches":
            batches == null ? null : List<dynamic>.from(batches.map((x) => x)),
        "isForAll": isForAll == null ? null : isForAll,
        "answers":
            answers == null ? null : List<Answer>.from(answers.map((x) => x)),
        "totalVotes": totalVotes == null ? null : totalVotes,
        "votes": votes == null
            ? null
            : Map.from(votes).map((k, v) =>
                MapEntry<String, dynamic>(k, double.parse(v.toString()))),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  double percent(String key) {
    final total = voteOnOption(key);
    if (total == 0) {
      return 0;
    }
    final perc = (total * 100); // / this.totalVotes;
    return perc;
  }

  double voteOnOption(String key) {
    return this.votes[key];
  }

  bool isMyVote(String studentId, String option) {
    if (this.answers != null && this.answers.isNotEmpty) {
      if (this.answers.any((element) =>
          element.studentId == studentId && element.option == option)) {
        return true;
      }
    }
    return false;
  }

  bool isVoted(String userId) {
    assert(userId != null,
        "User id Required to check if user has voted or not on poll");
    if (answers.isEmpty) {
      return false;
    }
    return answers.any((element) => element.studentId == userId);
  }
}

class Answer {
  Answer({
    this.studentId,
    this.option,
  });

  final String studentId;
  final String option;

  Answer copyWith({
    String studentId,
    String option,
  }) =>
      Answer(
        studentId: studentId ?? this.studentId,
        option: option ?? this.option,
      );

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        studentId: json["studentId"] == null ? null : json["studentId"],
        option: json["option"] == null ? null : json["option"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId == null ? null : studentId,
        "option": option == null ? null : option,
      };
}

class MySelection {
  final bool isSelected;
  final String choice;
  bool loading;

  MySelection({this.choice, this.isSelected = false, this.loading = false});
}
