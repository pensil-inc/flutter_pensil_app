import 'dart:io';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class BatchMaterialState extends BaseState {
  BatchMaterialState({String subject, String batchId}) {
    this.batchId = batchId;
    this.subject = subject;
  }
  String batchId;
  String articleUrl;
  String fileUrl;
  String title;
  String subject;
  File file;

  /// Container all video list
  List<BatchMaterialModel> list;
  void setArticleUrl(String url) {
    fileUrl = url;
  }

  set setFile(File data) {
    file = data;
    notifyListeners();
  }

  void removeFile() {
    file = null;
    notifyListeners();
  }

  Future<bool> uploadMaterial(String title, String description) async {
    final data = await execute(() async {
      assert(title != null);
      assert(subject != null);
      var model = BatchMaterialModel(title: title, description: description, subject: subject, batchId: batchId, articleUrl: fileUrl);
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      return await repo.uploadMaterial(model);
    }, label: "uploadMaterial");
    if (data != null && file != null) {
      await upload(data.id);
      isBusy = false;
      return true;
    }else if(fileUrl != null){
      isBusy = true;
      return false;
    }
     else {
      isBusy = false;
      return false;
    }
  }

  Future<bool> upload(String id) async {
    return await execute(() async {

      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      return await repo.uploadFile(file, id);
    }, label: "Upload File");
  }

  Future getBatchMaterialList() async {
    await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      list = await repo.getBatchMaterialList(batchId);
      if (list != null) {
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      notifyListeners();
      isBusy = false;
    }, label: "getBatchMaterialList");
  }
}
