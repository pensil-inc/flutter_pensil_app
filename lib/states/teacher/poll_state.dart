import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:get_it/get_it.dart';

class PollState extends ChangeNotifier {
  List<String> pollOptions = ["", ""];
  String question;

  void addValueToPollOption(String value, int index) {
    pollOptions[index] = value;
  }

  void addPollOptions() {
    pollOptions.add("");
    notifyListeners();
  }

  Future<PollModel> createPoll(String question) async {
    try {
      pollOptions.removeWhere((element) => element.isEmpty);
      assert(pollOptions.isNotEmpty);
      var model = PollModel(
          // title:title,
          batches: [""],
          endTime: DateTime.now().add(Duration(days: 1)),
          isForAll: true,
          options: pollOptions,
          question: question);
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      await repo.createPoll(model);
      return model;
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
      return null;
    }
  }
}
