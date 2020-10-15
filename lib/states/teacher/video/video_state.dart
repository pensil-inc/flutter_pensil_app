import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class VideoState extends BaseState {
  VideoState({String subject, String batchId}) {
    this.batchId = batchId;
    this.subject = subject;
  }
  String batchId;
  String videoUrl;
  String thumbnailUrl;
  String yTitle;
  String subject;

  /// Container all video list
  List<VideoModel> list;
  void setUrl({String videoUrl, String title, String thumbnailUrl}) {
    this.videoUrl = videoUrl;
    this.yTitle = title;
    this.thumbnailUrl = thumbnailUrl;
    notifyListeners();
  }

  Future<bool> addVideo(String title, String description) async {
    try {
      assert(title != null);
      var model = VideoModel(
        title: title,
        description: description,
        subject: "Physics",
        videoUrl: videoUrl,
        batchId:batchId,
        thumbnailUrl:thumbnailUrl
      );
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
    await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      list = await repo.getVideosList(batchId);
      if (list != null) {
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      notifyListeners();
      isBusy = false;
    }, label: "getVideosList");
  }
}
