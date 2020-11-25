import 'dart:developer';
import 'dart:io';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class AnnouncementState extends BaseState {
  final String batchId;
  File file;
  bool isForAll = true;
  List<AnnouncementModel> batchAnnouncementList;

  AnnouncementState({this.batchId});
  set setImageForAnnouncement(File io) {
    file = io;
    notifyListeners();
  }

  void removeAnnouncementImage() {
    file = null;
    notifyListeners();
  }

  void setIsForAll(bool value) {
    isForAll = value;
    notifyListeners();
  }

  Future getBatchAnnouncementList() async {
    await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      batchAnnouncementList = await repo.getBatchAnnouncemantList(batchId);
      if (batchAnnouncementList != null) {
        batchAnnouncementList
            .sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      notifyListeners();
      isBusy = false;
    }, label: "getBatchAnnouncementList");
  }

  Future<AnnouncementModel> createAnnouncement(
      {String title, String description, List<BatchModel> batches}) async {
    try {
      assert(title != null);
      var model = AnnouncementModel(
          // title:title,
          batches: batches == null
              ? null
              : batches
                  .where((element) => element.isSelected)
                  .map((e) => e.id)
                  .toList(),
          description: description,
          isForAll: batches == null
              ? true
              : batches.every((element) => !element.isSelected)
                  ? true
                  : isForAll);
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      final data = await repo.createAnnouncement(model);
      if (data != null) {
        if (file != null) {
          var ok = await upload(
            data.id,
          );
          isBusy = false;
          if (ok != null && ok) {
            return model;
          } else {
            return null;
          }
        }
      }
      return model;
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
      return null;
    }
  }

  Future<bool> upload(String id) async {
    return await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      return await repo.uploadFile(file, id, isAnouncement: true);
    }, label: "Upload Image");
  }
}
