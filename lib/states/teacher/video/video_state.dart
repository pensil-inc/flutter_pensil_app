import 'dart:developer';
import 'dart:io';

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
  File file;

  set setFile(File data) {
    file = data;
    notifyListeners();
  }

  void removeFile() {
    file = null;
    notifyListeners();
  }

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
      if (file == null && videoUrl == null) {
        return false;
      }
      assert(subject != null);
      var model = VideoModel(
          title: title, description: description, subject: subject, videoUrl: videoUrl ?? "https://truetechpro.snovasys.io/dashboard-management/dashboard/42cf1a89-801e-407f-9eb0-aad1a186637e", batchId: batchId, thumbnailUrl: thumbnailUrl);
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();

      final data = await execute(() async {
        return await repo.addVideo(model);
      }, label: "addVideo");
      if (data != null) {
        if (file != null) {
          bool ok = await upload(data.id);
          isBusy = false;
          if (ok != null && ok) {
            return true;
          } else {
            return false;
          }
        }
      }
      return false;
    } catch (error, strackTrace) {
      log("addVideo", error: error, stackTrace: strackTrace);
      return null;
    }
  }

  Future<bool> upload(String id) async {
    return await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      return await repo.uploadFile(file, id, isVideo: true);
    }, label: "Upload Video");
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
