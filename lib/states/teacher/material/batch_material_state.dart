import 'dart:developer';
import 'dart:io';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class BatchMaterialState extends BaseState {
  String articleUrl;
  String fileUrl;
  String title;
  String subject;
  File file;

  /// Container all video list
  List<VideoModel> list;
  void setArticleUrl(String url, String title) {
    fileUrl = url;
    title = title;
    notifyListeners();
  }

  set setSubject(String value) {
    subject = value;
    notifyListeners();
  }
  set setFile(File data){
    file = data;
    notifyListeners();
  }
  void removeFile(){
    file = null;
    notifyListeners();
  }

  Future<bool> addMaterial(String title, String description) async {
    try {
      assert(title != null);

      var model = VideoModel(title: title, description: description, subject: "Physics", url: fileUrl);
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      await repo.addVideo(model);
      return true;
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
      return null;
    }
  }

  Future getBatchMaterialList() async {
    await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      list = await repo.getVideosList();
      if (list != null) {
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      notifyListeners();
      isBusy = false;
    }, label: "getVideosList");
  }

  Future upload(File file) async {
    await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      fileUrl = await repo.uploadFile(file);
      notifyListeners();
      isBusy = true;
    });
  }
}
