import 'dart:developer';
import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class HomeState extends BaseState {
  List<BatchModel> batchList;
  List<AnnouncementModel> announcementList;
  List<PollModel> polls;
  String userId;

  Future getBatchList() async {
    try {
      final getit = GetIt.instance;
      final pref = getit.get<SharedPrefrenceHelper>();
      var user = await pref.getUserProfile();
      userId = user.id;
      final repo = getit.get<BatchRepository>();
      batchList = await repo.getBatch();
      notifyListeners();
    } catch (error, strackTrace) {
      log("getBatchList", error: error, stackTrace: strackTrace);
    }
  }

  Future getAnnouncemantList() async {
    try {
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      announcementList = await repo.getAnnouncemantList();
      announcementList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
    }
  }

  Future getPollList() async {
    try {
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      polls = await repo.getPollList();
      polls.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
    }
  }

  Future castVoteOnPoll(String pollId, String vote) async {
    var model = await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      return await repo.castVoteOnPoll(pollId, vote);
    }, label: "castVoteOnPoll");

    if (model != null) {
      var dt = polls.indexWhere((element) => element.id == model.id);
      polls[dt] = model;
      print("Voted sucess");
    }
    isBusy = false;
  }

  void logout() {
    batchList = null;
    polls = null;
    announcementList = null;
    final pref = GetIt.instance<SharedPrefrenceHelper>();
    pref.cleaPrefrenceValues();
  }
}
