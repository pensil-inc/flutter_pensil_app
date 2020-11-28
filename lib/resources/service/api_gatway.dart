import 'dart:io';

import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/notification_model.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/model/video_model.dart';

abstract class ApiGateway {
  Future<dynamic> getUser();
  Future<bool> createBatch(BatchModel model);
  Future<AnnouncementModel> createAnnouncement(AnnouncementModel model);
  Future<VideoModel> addVideo(VideoModel model);
  Future<ActorModel> login(ActorModel model);
  Future<bool> register(ActorModel model);
  Future<ActorModel> updateUser(ActorModel model);
  Future<bool> forgotPassword(ActorModel model);
  Future<ActorModel> loginWithGoogle(String token);
  Future<ActorModel> verifyOtp(ActorModel model);
  Future<List<BatchModel>> getBatches();
  Future<bool> createPoll(PollModel model);
  Future<List<AnnouncementModel>> getAnnouncemantList();
  Future<List<PollModel>> getPollList();
  Future<List<ActorModel>> getStudentList();
  Future<List<String>> getSubjectList();
  Future<List<NotificationModel>> getStudentNotificationsList();
  Future<List<VideoModel>> getVideosList(String batchId);
  Future<bool> uploadFile(File file, String id,
      {bool isVideo = false, bool isAnouncement = false});
  Future<BatchMaterialModel> uploadMaterial(BatchMaterialModel model);
  Future<List<BatchMaterialModel>> getBatchMaterialList(String batchId);
  Future<List<AnnouncementModel>> getBatchAnnouncemantList(String batchId);
  Future<List<AssignmentModel>> getAssignmentList(String batchId);
  Future<QuizDetailModel> getAssignmentDetailList(
      String batchId, String assgnmentId);
  Future<PollModel> castVoteOnPoll(String pollId, String vote);
}
