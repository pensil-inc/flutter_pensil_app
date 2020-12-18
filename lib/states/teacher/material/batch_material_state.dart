import 'dart:developer';
import 'dart:io';
import 'package:flutter_pensil_app/helper/constants.dart';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class BatchMaterialState extends BaseState {
  BatchMaterialState({
    String subject,
    String batchId,
    BatchMaterialModel materialModel,
    bool isEditMode = false,
  }) {
    this.batchId = batchId;
    this.subject = subject;
    this.materialModel = materialModel ?? BatchMaterialModel();
    this.isEditMode = isEditMode;
  }
  String batchId;
  String articleUrl;
  String fileUrl;
  String title;
  String subject;
  File file;
  bool isEditMode = false;
  BatchMaterialModel materialModel;

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
      var model = materialModel.copyWith(
          title: title,
          description: description,
          subject: subject,
          batchId: batchId,
          articleUrl: fileUrl);
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      return await repo.uploadMaterial(model, isEdit: isEditMode);
    }, label: "uploadMaterial");

    /// If received data from api and we have material to upload
    if (data != null && file != null) {
      await upload(data.id);
      isBusy = false;
      return true;
    }

    /// In material edit mode file url is not null
    /// It means a file is already avilable at server
    else if (materialModel.file != null) {
      isBusy = false;
      return true;
    }

    /// If we have article Url
    else if (fileUrl != null) {
      isBusy = false;
      return true;
    } else {
      isBusy = false;
      return false;
    }
  }

  Future<bool> upload(String id) async {
    String endpoint = Constants.material + "/$id/upload";
    return await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      return await repo.uploadFile(file, id, endpoint: endpoint);
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

  Future deleteMaterial(String id) async {
    try {
      var isDeleted = await deleteById(Constants.crudMaterial(id));
      if (isDeleted) {
        list.removeWhere((element) => element.id == id);
      }
      notifyListeners();
      return isDeleted;
    } catch (error) {
      log("deleteMaterial", error: error, name: this.runtimeType.toString());
      return false;
    }
  }
}
