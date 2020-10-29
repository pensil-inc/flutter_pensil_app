import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
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
  BatchRepository(this.gatway,this.sessionService);
  Future<bool> createBatch(BatchModel model){
    return gatway.createBatch(model); 
  }
   Future<bool> createAnnouncement(AnnouncementModel model){
    return gatway.createAnnouncement(model); 
  }
  Future<bool> login(ActorModel model)async{
    var actor = await gatway.login(model); 
    await sessionService.saveSession(actor);
    return true;
  }

  Future<List<BatchModel>> getBatch(){
    return gatway.getBatches(); 
  }
  Future<List<AnnouncementModel>> getAnnouncemantList(){
    return gatway.getAnnouncemantList();
  }
  Future<List<PollModel>> getPollList(){
    return gatway.getPollList();
  }

  

  Future<List<NotificationModel>> getStudentNotificationsList(){
    return gatway.getStudentNotificationsList();
  }
  Future<List<VideoModel>> getVideosList(String batchId){
    return gatway.getVideosList(batchId);
  }
  Future<List<BatchMaterialModel>> getBatchMaterialList(String batchId){
    return gatway.getBatchMaterialList(batchId);
  }

  Future<List<AnnouncementModel>> getBatchAnnouncemantList(String batchId){
    return gatway.getBatchAnnouncemantList(batchId);
  }

  Future<List<AssignmentModel>> getAssignmentList(String batchId){
    return gatway.getAssignmentList(batchId);
  }

  Future<QuizDetailModel> getAssignmentDetailList(String batchId,String assgnmentId){
    return gatway.getAssignmentDetailList(batchId,assgnmentId);
  }
}
