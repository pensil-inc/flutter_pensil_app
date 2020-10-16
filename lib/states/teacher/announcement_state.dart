import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class AnnouncementState extends BaseState {
  final String batchId;
  bool isForAll = false;
  List<AnnouncementModel> batchAnnouncementList;

  AnnouncementState({this.batchId});
  void setIsForAll(bool value) {
    isForAll = value;
    notifyListeners();
  }

  Future<AnnouncementModel> createAnnouncement({String title, String description, List<BatchModel> batches}) async {
    try {
      assert(title != null);
      var model = AnnouncementModel(
          // title:title,
          batches: batches == null ? null : batches.where((element) => element.isSelected).map((e) => e.id).toList(),
          description: description,
          isForAll: batches == null
              ? true
              : batches.every((element) => !element.isSelected)
                  ? true
                  : isForAll);
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      await repo.createAnnouncement(model);
      return model;
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
      return null;
    }
  }

  Future getBatchAnnouncementList() async {
    await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      batchAnnouncementList = await repo.getBatchAnnouncemantList(batchId);
      if (batchAnnouncementList != null) {
        batchAnnouncementList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      notifyListeners();
      isBusy = false;
    }, label: "getBatchAnnouncementList");
  }
}
