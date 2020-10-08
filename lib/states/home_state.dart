import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:get_it/get_it.dart';

class HomeState extends ChangeNotifier {
 
  List<BatchModel> batchList;
  List<AnnouncementModel> announcementList;
  List<PollModel> polls;

  Future getBatchList()async{
    try{
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      batchList = await repo.getBatch();
      notifyListeners();
    }catch(error,strackTrace){
      log("createBatch", error:error, stackTrace:strackTrace);
    }
  }

  Future getAnnouncemantList()async{
    try{
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      announcementList = await repo.getAnnouncemantList();
      announcementList.sort((a,b) => a.createdAt.compareTo(b.createdAt));
      notifyListeners();
    }catch(error,strackTrace){
      log("createBatch", error:error, stackTrace:strackTrace);
    }
  }
  
  Future getPollList()async{
    try{
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      polls = await repo.getPollList();
      polls.sort((a,b) => a.createdAt.compareTo(b.createdAt));
      notifyListeners();
    }catch(error,strackTrace){
      log("createBatch", error:error, stackTrace:strackTrace);
    }
  }
}