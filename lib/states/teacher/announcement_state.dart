import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:get_it/get_it.dart';

class AnnouncementState extends ChangeNotifier{
  bool isForAll = false;
  
  void setIsForAll(bool value){
    isForAll = value;
    notifyListeners();
  }
  Future<AnnouncementModel> createAnnouncement({String title,String description, List<BatchModel> batches})async{
    try{
      assert(title != null);
      var model = AnnouncementModel(
        // title:title,
        batches:batches == null ? null : batches.where((element) => element.isSelected).map((e) => e.id).toList(),
        description: description,
        isForAll: batches == null ? true : batches.every((element) => !element.isSelected)  ? true : isForAll
      );
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      await repo.createAnnouncement(model);
      return model;
    }catch (error, strackTrace){
      log("createBatch", error:error, stackTrace:strackTrace);
      return null;
    }
  }
}