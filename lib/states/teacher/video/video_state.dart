import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class VideoState extends BaseState {
  String yUrl;
  String yTitle;
  String subject;

  /// Container all video list
  List<VideoModel> list;
  void setUrl(String url, String title) {
    yUrl = url;
    yTitle = title;
    notifyListeners();
  }

  set setSubject(String value) {
    subject = value;
    notifyListeners();
  }

  Future<bool> addVideo(String title, String description) async {
    try {
      assert(title != null);
      var model = VideoModel(title: title, description: description, subject: "Physics", url: yUrl);
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      await repo.addVideo(model);
      return true;
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
      return null;
    }
  }

  Future getVideosList() async {
    await execute(
      () async {
        isBusy = true;
        final getit = GetIt.instance;
        final repo = getit.get<BatchRepository>();
        list = await repo.getVideosList();
        if (list != null) {
          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        }
        notifyListeners();
        isBusy = false;
      },
      label:"getVideosList"
    );
  }
}
