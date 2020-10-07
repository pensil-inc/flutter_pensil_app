import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/session/session.dart';
import 'package:flutter_pensil_app/states/auth/actor_model.dart';
import 'package:flutter_pensil_app/states/create_announcement_model.dart';

class BatchRepository {
  final ApiGateway gatway;
  final SessionService sessionService;
  BatchRepository(this.gatway,this.sessionService);
  Future<bool> createBatch(BatchModel model){
    return gatway.createBatch(model); 
  }
   Future<bool> createAnnouncement(CreateAnnouncementModel model){
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
}