import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/batch_timeline_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/notification_model.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/session/session.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';

class BatchRepository {
  final ApiGateway gatway;
  final SessionService sessionService;
  BatchRepository(this.gatway, this.sessionService);
  Future<bool> createBatch(BatchModel model) {
    return gatway.createBatch(model);
  }

  Future<AnnouncementModel> createAnnouncement(AnnouncementModel model,
      {bool isEdit}) {
    return gatway.createAnnouncement(model, isEdit: isEdit);
  }

  Future<bool> login(ActorModel model) async {
    var actor = await gatway.login(model);
    await sessionService.saveSession(actor);
    return true;
  }

  Future<bool> register(ActorModel model) async {
    return gatway.register(model);
  }

  Future<bool> updateUser(ActorModel model) async {
    var actor = await gatway.updateUser(model);
    await sessionService.saveSession(actor);
    return true;
  }

  Future<bool> forgotPassword(ActorModel model) async {
    return gatway.forgotPassword(model);
  }

  Future<bool> loginWithGoogle(String token) async {
    var actor = await gatway.loginWithGoogle(token);
    await sessionService.saveSession(actor);
    return true;
  }

  Future<dynamic> verifyOtp(ActorModel model) async {
    var actor = await gatway.verifyOtp(model);
    await sessionService.saveSession(actor);
    return true;
  }

  Future<List<BatchModel>> getBatch() {
    return gatway.getBatches();
  }

  Future<bool> deleteById(String typeAndId) {
    return gatway.deleteBatch(typeAndId);
  }

  Future<List<AnnouncementModel>> getAnnouncemantList() {
    return gatway.getAnnouncemantList();
  }

  Future<List<PollModel>> getPollList() {
    return gatway.getPollList();
  }

  Future<List<NotificationModel>> getStudentNotificationsList() {
    return gatway.getStudentNotificationsList();
  }

  Future<List<VideoModel>> getVideosList(String batchId) {
    return gatway.getVideosList(batchId);
  }

  Future<List<BatchMaterialModel>> getBatchMaterialList(String batchId) {
    return gatway.getBatchMaterialList(batchId);
  }

  Future<List<AnnouncementModel>> getBatchAnnouncemantList(String batchId) {
    return gatway.getBatchAnnouncemantList(batchId);
  }

  Future<List<BatchTimeline>> getBatchDetailTimeLine(String batchId) {
    return gatway.getBatchDetailTimeLine(batchId);
  }

  Future<List<AssignmentModel>> getAssignmentList(String batchId) {
    return gatway.getAssignmentList(batchId);
  }

  Future<QuizDetailModel> getAssignmentDetailList(
      String batchId, String assgnmentId) {
    return gatway.getAssignmentDetailList(batchId, assgnmentId);
  }

  Future<PollModel> castVoteOnPoll(String pollId, String vote) {
    return gatway.castVoteOnPoll(pollId, vote);
  }
}
