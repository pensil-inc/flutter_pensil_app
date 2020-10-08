import 'dart:convert';
class PollResponseModel {
    PollResponseModel({
        this.polls,
    });

    final List<PollModel> polls;

    factory PollResponseModel.fromRawJson(String str) => PollResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PollResponseModel.fromJson(Map<String, dynamic> json) => PollResponseModel(
        polls: json["polls"] == null ? null : List<PollModel>.from(json["polls"].map((x) => PollModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "polls": polls == null ? null : List<dynamic>.from(polls.map((x) => x.toJson())),
    };
}
class PollModel {
    PollModel({
        this.question,
        this.options,
        this.endTime,
        this.isForAll,
        this.batches,
        this.createdAt
    });

    final String question;
    final List<String> options;
    final String endTime;
    final bool isForAll;
    final List<String> batches;
    final DateTime createdAt;

    factory PollModel.fromRawJson(String str) => PollModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PollModel.fromJson(Map<String, dynamic> json) => PollModel(
        question: json["question"] == null ? null : json["question"],
        options: json["options"] == null ? null : List<String>.from(json["options"].map((x) => x)),
        endTime: json["endTime"] == null ? null : json["endTime"],
        isForAll: json["isForAll"] == null ? null : json["isForAll"],
        batches: json["batches"] == null ? null : List<String>.from(json["batches"].map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "question": question == null ? null : question,
        "options": options == null ? null : List<dynamic>.from(options.map((x) => x)),
        "endTime": endTime == null ? null : endTime,
        "isForAll": isForAll == null ? null : isForAll,
        "batches": batches == null ? null : List<dynamic>.from(batches.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    };
}
