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
  void setArticleUrl(
    String url,
  ) {
    fileUrl = url;
    notifyListeners();
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
      var model = BatchMaterialModel(
        title: title,
        description: description,
        subject: subject,
        batchId: batchId,
      );
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      return await repo.uploadMaterial(model);
    }, label: "uploadMaterial");
    if (data != null) {
      await upload(data.id);
      isBusy = false;
      return true;
    } else {
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
      list = await repo.getBatchMaterialList();
      if (list != null) {
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      // list = [
      //   BatchMaterialModel(
      //       batchId: "ewdwe",
      //       title: "Applied mathmatics",
      //       createdAt: DateTime.now(),
      //       description: "sdfsdfsdfsdvsd ds sd sd c",
      //       file: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
      //       fileType: "pdf",
      //       subject: "English",
      //       id: "sdf"),
      //   BatchMaterialModel(
      //       batchId: "ewdwe",
      //       title: "Physics part 1",
      //       createdAt: DateTime.now(),
      //       description: "sdfsdfsdfsdvsd ds sd sd c",
      //       file: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
      //       fileType: "pdf",
      //       subject: "English",
      //       id: "sdf"),
      // ];
      notifyListeners();
      isBusy = false;
    }, label: "getVideosList");
  }
}
