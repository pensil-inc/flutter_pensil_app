import 'dart:developer';
import 'package:flutter_pensil_app/helper/enum.dart';
import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
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
  Future<ActorModel> user;
  bool isTeacher = true;

  Future getBatchList() async {
    try {
      final getit = GetIt.instance;
      final pref = getit.get<SharedPrefrenceHelper>();
      var user = await pref.getUserProfile();
      userId = user.id;
      isTeacher = user.role == Role.TEACHER.asString();
      final repo = getit.get<BatchRepository>();
      batchList = await repo.getBatch();
      notifyListeners();
    } catch (error) {
      log("getBatchList", error: error, name: this.runtimeType.toString());
    }
  }

  Future getAnnouncemantList() async {
    try {
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      announcementList = await repo.getAnnouncemantList();
      announcementList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    } catch (error) {
      log("createBatch", error: error, name: this.runtimeType.toString());
    }
  }

  Future getPollList() async {
    try {
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      polls = await repo.getPollList();
      polls.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    } catch (error) {
      log("createBatch", error: error, name: this.runtimeType.toString());
    }
  }

  Future castVoteOnPoll(String pollId, String vote) async {
    if (isTeacher) {
      print("Teacher can't cast vote");
      return;
    }
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
    userId = null;
    announcementList = null;
    final pref = GetIt.instance<SharedPrefrenceHelper>();
    pref.cleaPrefrenceValues();
  }

  Future<ActorModel> getUser() {
    final pref = GetIt.instance<SharedPrefrenceHelper>();
    user = user ?? pref.getUserProfile();
    return user;
  }
}
