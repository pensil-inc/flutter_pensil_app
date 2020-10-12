import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/notification_model.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/model/video_model.dart';

abstract class ApiGateway {
  Future<dynamic> getUser();
  Future<bool> createBatch(BatchModel model);
  Future<bool> createAnnouncement(AnnouncementModel model);
  Future<bool> addVideo(VideoModel model);
  Future<ActorModel> login(ActorModel model);
  Future<List<BatchModel>> getBatches();
  Future<bool> createPoll(PollModel model);
  Future<List<AnnouncementModel>> getAnnouncemantList();
  Future<List<PollModel>> getPollList();
  Future<List<ActorModel>> getStudentList();
  Future<List<NotificationModel>> getStudentNotificationsList();
  Future<List<VideoModel>> getVideosList();
}