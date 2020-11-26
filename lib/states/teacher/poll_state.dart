import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:get_it/get_it.dart';

class PollState extends ChangeNotifier {
  List<String> pollOptions = ["", ""];
  String question;
  DateTime lastDate;
  String lastTime;

  set setLastDate(DateTime value) {
    lastDate = value;
    notifyListeners();
  }

  set setPollExpireTime(String value) {
    lastTime = value;
    notifyListeners();
  }

  void addValueToPollOption(String value, int index) {
    pollOptions[index] = value;
  }

  void removePollOption(int index) {
    var val = pollOptions[index];
    pollOptions.remove(val);
    notifyListeners();
  }

  void addPollOptions() {
    pollOptions.add("");
    notifyListeners();
  }

  String get lastPollDate {
    var date = lastDate != null ? Utility.toDMYformate(lastDate) : "Date";
    return date;
  }

  String get lastPollTime {
    var date = lastTime != null ? lastTime : "Time";
    return date;
  }

  Future<PollModel> createPoll(String question) async {
    try {
      pollOptions.removeWhere((element) => element.isEmpty);
      assert(pollOptions.isNotEmpty);
      var model = PollModel(
          // title:title,
          batches: [""],
          endTime: lastDate.add(Duration(
              hours: int.parse(lastTime.split(":")[0]),
              minutes: int.tryParse(lastTime.split(":")[1]))),
          isForAll: true,
          options: pollOptions,
          question: question);
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      await repo.createPoll(model);
      return model;
      // print(model.toJson());
      // return Future.value(null);
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
      return null;
    }
  }
}
