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
      var endpoint = model.id == null
          ? Constants.batch
          : Constants.editBatchDetail(model.id);
      var response = await _dioClient.post(endpoint,
          data: data, options: Options(headers: header));
      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<AnnouncementModel> createAnnouncement(AnnouncementModel model) async {
    try {
      final mapJson = model.toJson();
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      var response = await _dioClient.post(Constants.annoucenment,
          data: mapJson, options: Options(headers: header));
      final map = _dioClient.getJsonBody(response);
      final data = AnnouncementModel.fromJson(map["announcement"]);
      return data;
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
      data.removeWhere((key, value) => value == null);
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
  Future<bool> register(ActorModel model) async {
    try {
      final getit = GetIt.instance<NotificationService>();
      final fcmToken = await getit.getDeviceToken();
      model.fcmToken = fcmToken;
      final data = model.toJson();
      var response = await _dioClient.post(
        Constants.register,
        data: data,
      );

      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<bool> forgotPassword(ActorModel model) async {
    try {
      final data = model.toJson();
      data.removeWhere((key, value) => value == null);
      await _dioClient.post(Constants.forgotPassword, data: data);
      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<ActorModel> verifyOtp(ActorModel model) async {
    try {
      final data = model.toJson();
      data.removeWhere((key, value) => value == null);
      var response = await _dioClient.post(
        Constants.verifyOtp,
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
  Future<ActorModel> updateUser(ActorModel model) async {
    try {
      final data = model.toJson();
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      data.removeWhere((key, value) => value == null);
      var response = await _dioClient.post(
        Constants.profile,
        data: data,
        options: Options(headers: header),
      );
      var map = _dioClient.getJsonBody(response);
      var actor = ActorModel.fromJson(map["user"]);
      return actor;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<ActorModel> loginWithGoogle(String token) async {
    try {
      // final getit = GetIt.instance<NotificationService>();
      // final fcmToken = await getit.getDeviceToken();
      // model.fcmToken = fcmToken;
      // final data = model.toJson();
      final header = {"Authorization": "Bearer " + token};
      var response = await _dioClient.get(Constants.googleAuth,
          // data: data,
          options: Options(headers: header));
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
      var token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      String endpoint =
          await pref.isStudent() ? Constants.studentBatch : Constants.batch;
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

  @override
  Future<bool> deleteBatch(String typeAndId) async {
    try {
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};

      await _dioClient.delete(
        typeAndId,
        options: Options(headers: header),
      );
      return true;
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
      String endpoint = await pref.isStudent()
          ? Constants.studentAnnouncements
          : Constants.annoucenment;
      final response =
          await _dioClient.get(endpoint, options: Options(headers: header));
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
      String endpoint =
          await pref.isStudent() ? Constants.studentPolls : Constants.poll;
      final response =
          await _dioClient.get(endpoint, options: Options(headers: header));
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
  Future<VideoModel> addVideo(VideoModel model, {bool isEdit = false}) async {
    try {
      final data = model.toJson();
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final endpoint = isEdit ? Constants.crudVideo(model.id) : Constants.video;
      final response = await _dioClient.post(endpoint,
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
  Future<bool> uploadFile(File file, String id,
      {bool isVideo = false, bool isAnouncement = false}) async {
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
      String path = isAnouncement
          ? Constants.annoucenment
          : isVideo
              ? Constants.video
              : Constants.material;
      await _dioClient.post(path + "/$id/upload",
          data: data, options: Options(headers: header));
      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<BatchMaterialModel> uploadMaterial(BatchMaterialModel model,
      {bool isEdit = false}) async {
    try {
      final data = model.toJson();
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final endpoint =
          isEdit ? Constants.crudMaterial(model.id) : Constants.material;
      final response = await _dioClient.post(endpoint,
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
      final header = {"Authorization": "Bearer " + token};
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

  @override
  Future<PollModel> castVoteOnPoll(String pollId, String vote) async {
    try {
      final data = {"answer": vote};
      String token = await pref.getAccessToken();
      final header = {"Authorization": "Bearer " + token};
      final response = await _dioClient.post(
          Constants.castStudentVotOnPoll(pollId),
          data: data,
          options: Options(headers: header));
      final map = _dioClient.getJsonBody(response);
      final value = PollModel.fromJson(map["poll"]);
      return value;
    } catch (error) {
      throw error;
    }
  }
}
