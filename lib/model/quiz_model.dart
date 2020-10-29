import 'dart:convert';

class QuizRepsonseModel {
    QuizRepsonseModel({
        this.assignments,
    });

    final List<AssignmentModel> assignments;
    

    QuizRepsonseModel copyWith({
        List<AssignmentModel> assignments,
    }) => 
        QuizRepsonseModel(
            assignments: assignments ?? this.assignments,
        );

    factory QuizRepsonseModel.fromRawJson(String str) => QuizRepsonseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory QuizRepsonseModel.fromJson(Map<String, dynamic> json) => QuizRepsonseModel(
        assignments: json["assignments"] == null ? null : List<AssignmentModel>.from(json["assignments"].map((x) => AssignmentModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "assignments": assignments == null ? null : List<dynamic>.from(assignments.map((x) => x.toJson())),
    };
}
class AssignmentModel {
    AssignmentModel({
        this.id,
        this.title,
        this.duration,
        this.owner,
        this.questions,
    });

    final String id;
    final String title;
    final int duration;
    final String owner;
    final int questions;

    AssignmentModel copyWith({
        String id,
        String title,
        int duration,
        String owner,
        int questions,
    }) => 
        AssignmentModel(
            id: id ?? this.id,
            title: title ?? this.title,
            duration: duration ?? this.duration,
            owner: owner ?? this.owner,
            questions: questions ?? this.questions,
        );

    factory AssignmentModel.fromRawJson(String str) => AssignmentModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AssignmentModel.fromJson(Map<String, dynamic> json) => AssignmentModel(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        duration: json["duration"] == null ? null : json["duration"],
        owner: json["owner"] == null ? null : json["owner"],
        questions: json["questions"] == null ? null : json["questions"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "duration": duration == null ? null : duration,
        "owner": owner == null ? null : owner,
        "questions": questions == null ? null : questions,
    };
}
class QuizDetailModel {
  QuizDetailModel({
    this.title,
    this.duration,
    this.owner,
    this.batch,
    this.questions,
    this.answers,
    this.createdAt,
    this.updatedAt,
  });

  final String title;
  final int duration;
  final String owner;
  final String batch;
  final List<Question> questions;
  final List<QuizRepsonseModelAnswer> answers;
  final String createdAt;
  final String updatedAt;

  QuizDetailModel copyWith({
    String title,
    int duration,
    String owner,
    String batch,
    List<Question> questions,
    List<QuizRepsonseModelAnswer> answers,
    String createdAt,
    String updatedAt,
  }) =>
      QuizDetailModel(
        title: title ?? this.title,
        duration: duration ?? this.duration,
        owner: owner ?? this.owner,
        batch: batch ?? this.batch,
        questions: questions ?? this.questions,
        answers: answers ?? this.answers,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory QuizDetailModel.fromRawJson(String str) => QuizDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizDetailModel.fromJson(Map<String, dynamic> json) => QuizDetailModel(
        title: json["title"] == null ? null : json["title"],
        duration: json["duration"] == null ? null : json["duration"],
        owner: json["owner"] == null ? null : json["owner"],
        batch: json["batch"] == null ? null : json["batch"],
        questions: json["questions"] == null ? null : List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
        answers: json["answers"] == null
            ? null
            : List<QuizRepsonseModelAnswer>.from(json["answers"].map((x) => QuizRepsonseModelAnswer.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "duration": duration == null ? null : duration,
        "owner": owner == null ? null : owner,
        "batch": batch == null ? null : batch,
        "questions": questions == null ? null : List<dynamic>.from(questions.map((x) => x.toJson())),
        "answers": answers == null ? null : List<dynamic>.from(answers.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
      };
  static QuizDetailModel dummyData = QuizDetailModel.fromJson(map);
  static dynamic map = {
    "title": "sdfsdf",
    "duration": 120,
    "owner": "3423489er8wr7w879er762387423",
    "batch": "324234234234234234",
    "questions": [
      {
        "id": "234232334234234",
        "statement": "Some question here",
        "options": ["Option 1 ", "Options 2"],
        "answer": "asdasd"
      },
       {
        "id": "2342323423324234",
        "statement": "Another question here",
        "options": ["Option 1 ", "Options 2","Options 3"],
        "answer": "asdasd"
      },
      {
        "id": "2344223422234234",
        "statement": "Some  Another question here",
        "options": ["Option 1 ", "Options 2","Options 3","Options 4","Options 6"],
        "answer": "asdasd"
      }
    ],
    "answers": [
      {
        "student": "erewrwerwer45353rewrwerwe",
        "answers": [
          {"question": "234234234234", "option": "234234234234"}
        ],
        "correct": 5,
        "incorrect": 2,
        "skipped": 0,
        "timeTaken": 101
      }
    ],
    "createdAt": "time",
    "updatedAt": "time"
  };
}

class QuizRepsonseModelAnswer {
  QuizRepsonseModelAnswer({
    this.student,
    this.answers,
    this.correct,
    this.incorrect,
    this.skipped,
    this.timeTaken,
  });

  final String student;
  final List<AnswerAnswer> answers;
  final int correct;
  final int incorrect;
  final int skipped;
  final int timeTaken;

  QuizRepsonseModelAnswer copyWith({
    String student,
    List<AnswerAnswer> answers,
    int correct,
    int incorrect,
    int skipped,
    int timeTaken,
  }) =>
      QuizRepsonseModelAnswer(
        student: student ?? this.student,
        answers: answers ?? this.answers,
        correct: correct ?? this.correct,
        incorrect: incorrect ?? this.incorrect,
        skipped: skipped ?? this.skipped,
        timeTaken: timeTaken ?? this.timeTaken,
      );

  factory QuizRepsonseModelAnswer.fromRawJson(String str) => QuizRepsonseModelAnswer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizRepsonseModelAnswer.fromJson(Map<String, dynamic> json) => QuizRepsonseModelAnswer(
        student: json["student"] == null ? null : json["student"],
        answers: json["answers"] == null ? null : List<AnswerAnswer>.from(json["answers"].map((x) => AnswerAnswer.fromJson(x))),
        correct: json["correct"] == null ? null : json["correct"],
        incorrect: json["incorrect"] == null ? null : json["incorrect"],
        skipped: json["skipped"] == null ? null : json["skipped"],
        timeTaken: json["timeTaken"] == null ? null : json["timeTaken"],
      );

  Map<String, dynamic> toJson() => {
        "student": student == null ? null : student,
        "answers": answers == null ? null : List<dynamic>.from(answers.map((x) => x.toJson())),
        "correct": correct == null ? null : correct,
        "incorrect": incorrect == null ? null : incorrect,
        "skipped": skipped == null ? null : skipped,
        "timeTaken": timeTaken == null ? null : timeTaken,
      };
}

class AnswerAnswer {
  AnswerAnswer({
    this.question,
    this.option,
  });

  final String question;
  final String option;

  AnswerAnswer copyWith({
    String question,
    String option,
  }) =>
      AnswerAnswer(
        question: question ?? this.question,
        option: option ?? this.option,
      );

  factory AnswerAnswer.fromRawJson(String str) => AnswerAnswer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AnswerAnswer.fromJson(Map<String, dynamic> json) => AnswerAnswer(
        question: json["question"] == null ? null : json["question"],
        option: json["option"] == null ? null : json["option"],
      );

  Map<String, dynamic> toJson() => {
        "question": question == null ? null : question,
        "option": option == null ? null : option,
      };
}

class Question {
  Question({
    this.id,
    this.statement,
    this.options,
    this.answer,
    this.selectedAnswer
  });

  final String id;
  final String statement;
  final List<String> options;
  final String answer;
  String selectedAnswer;

  Question copyWith({
    String id,
    String statement,
    List<String> options,
    String answer,
    String selectedAnswer,
  }) =>
      Question(
        id: id ?? this.id,
        statement: statement ?? this.statement,
        options: options ?? this.options,
        answer: answer ?? this.answer,
        selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      );

  factory Question.fromRawJson(String str) => Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"] == null ? null : json["id"],
        statement: json["statement"] == null ? null : json["statement"],
        options: json["options"] == null ? null : List<String>.from(json["options"].map((x) => x)),
        answer: json["answer"] == null ? null : json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "statement": statement == null ? null : statement,
        "options": options == null ? null : List<dynamic>.from(options.map((x) => x)),
        "answer": answer == null ? null : answer,
      };
}
