import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_pensil_app/helper/constants.dart';
import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/notification_model.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/model/subject.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/dio_client.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/resources/service/notification_service.dart';
import 'package:get_it/get_it.dart';

class ApiGatewayImpl implements ApiGateway {
  final DioClient _dioClient;
  final SharedPrefrenceHelper pref;
  ApiGatewayImpl(this._dioClient, {this.pref});

  @override
  Future getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> createBatch(BatchModel model) async {
    try {
      final data = model.toJson();
      print(data);
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      var response = await _dioClient.post(Constants.batch,
          data: data, options: Options(headers: header));
      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<bool> createAnnouncement(AnnouncementModel model) async {
    try {
      final data = model.toJson();
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      var response = await _dioClient.post(Constants.annoucenment,
          data: data, options: Options(headers: header));
      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<ActorModel> login(ActorModel model) async {
    try {
      final getit = GetIt.instance<NotificationService>();
      final fcmToken = await getit.getDeviceToken();
      model.fcmToken = fcmToken;
      final data = model.toJson();
      var response = await _dioClient.post(
        Constants.login,
        data: data,
      );
      var map = _dioClient.getJsonBody(response);
      var actor = ActorModel.fromJson(map["user"]);
      return actor;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<BatchModel>> getBatches() async {
    try {
      String token = await pref.getAccessToken();

      final header = {"Authorization": "Bearer " + token};
      String endpoint =
          await pref.isStudent() ? Constants.batchStudent : Constants.batch;
      var response = await _dioClient.get(
        endpoint,
        options: Options(headers: header),
      );
      var json = _dioClient.getJsonBody(response);
      final list = BatchResponseModel.fromJson(json);
      return list.batches;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> createPoll(PollModel model) async {
    try {
      final data = model.toJson();
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      await _dioClient.post(Constants.poll,
          data: data, options: Options(headers: header));
      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<AnnouncementModel>> getAnnouncemantList() async {
    try {
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(Constants.annoucenment,
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = AnnouncementListResponse.fromJson(json);
      return model.announcements;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<PollModel>> getPollList() async {
    try {
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(Constants.poll,
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = PollResponseModel.fromJson(json);
      return model.polls;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<ActorModel>> getStudentList() async {
    try {
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(Constants.getAllStudentList,
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = StudentResponseModel.fromJson(json);
      // pref.saveStudent(model);
      return model.students;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<String>> getSubjectList() async {
    try {
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(Constants.subjects,
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = SubjectReponseModel.fromJson(json);
      // pref.saveSubjects(model);
      return model.subjects;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<NotificationModel>> getStudentNotificationsList() async {
    try {
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(Constants.studentNotificationList,
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = NotificationResponseModel.fromJson(json);
      return model.notifications;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<VideoModel> addVideo(VideoModel model) async {
    try {
      final data = model.toJson();
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.post(Constants.video,
          data: data, options: Options(headers: header));
      final map = _dioClient.getJsonBody(response);
      final value = VideoModel.fromJson(map["video"]);
      return value;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<VideoModel>> getVideosList(String batchId) async {
    try {
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(
          Constants.getBatchVideoList(batchId),
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = VideosRsponseModel.fromJson(json);
      return model.videos;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<bool> uploadFile(File file, String id, {bool isVideo = false}) async {
    try {
      String fileName = file.path.split('/').last;

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      String path = isVideo ? Constants.video : Constants.material;
      await _dioClient.post(path + "/$id/upload",
          data: data, options: Options(headers: header));
      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<BatchMaterialModel> uploadMaterial(BatchMaterialModel model) async {
    try {
      final data = model.toJson();
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.post(Constants.material,
          data: data, options: Options(headers: header));
      final map = _dioClient.getJsonBody(response);
      print(map);
      final ma = BatchMaterialModel.fromJson(map["material"]);
      return ma;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<BatchMaterialModel>> getBatchMaterialList(String batchId) async {
    try {
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(
          Constants.getBatchMaterialList(batchId),
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = BatchMaterialRespopnseModel.fromJson(json);
      return model.materials;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<AnnouncementModel>> getBatchAnnouncemantList(
      String batchId) async {
    try {
      assert(batchId != null);
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(
          Constants.getBatchAnnouncementList(batchId),
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = AnnouncementListResponse.fromJson(json);
      return model.announcements;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<AssignmentModel>> getAssignmentList(String batchId) async {
    try {
      assert(batchId != null);
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.get(
          Constants.getBatchAssignmentList(batchId),
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = QuizRepsonseModel.fromJson(json);
      return model.assignments;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<QuizDetailModel> getAssignmentDetailList(
      String batchId, String assgnmentId) async {
    try {
      assert(batchId != null);
      String token = await pref.getAccessToken();
      final header = {
        "Authorization": "Bearer " +
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc1ZlcmlmaWVkIjp0cnVlLCJsYXN0TG9naW5EYXRlIjoiMjAyMC0xMC0yOVQwNjozNDoyMC42MTNaIiwibmFtZSI6Ik5ldyBVc2VyIiwibW9iaWxlIjoiODIxODU3ODQ5OSIsInJvbGUiOiJzdHVkZW50IiwiY3JlYXRlZEF0IjoiMjAyMC0xMC0xMFQxNDozOToxMi42ODFaIiwidXBkYXRlZEF0IjoiMjAyMC0xMC0yOVQwNjozNDoyMC42MjBaIiwiZmNtVG9rZW4iOiJkNUZ5ZktVNVNXeVQzT1ZJT0hPVks3OkFQQTkxYkhOSTZnd1FuclVWZEVoYWY2am9RRkpHZm84V2Zid1EtdzJNNWM3MjB5NkxxZk1ya3lPTUNrbHBtRkVNU25JNnp5aFZWQ0xRS3pGbU53TTl4c2std0F6SG4yRlMwd1JGTEZBU3k1TUhkWm9pLUxEdDJwMy1KRFBOMEtWc19WakQxYW5CQjY3IiwiaWQiOiI1ZjgxYzc5MGJhZjY2NDAwMTdkOGNjY2IiLCJpYXQiOjE2MDM5NTMyNjB9.UTcM3OUTai8RT0mnAf5vnIBbIIfrcrzVipE3hH1oRp4"
      };
      final response = await _dioClient.get(
          Constants.getBatchAssignmentDetail(batchId, assgnmentId),
          options: Options(headers: header));
      var json = _dioClient.getJsonBody(response);
      final model = QuizDetailModel.fromJson(json["assignment"][0]);
      return model;
    } catch (error) {
      throw error;
    }
  }
}
