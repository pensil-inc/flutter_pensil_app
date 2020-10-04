import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/states/create_announcement_model.dart';

class BatchRepository {
  final ApiGateway gatway;

  BatchRepository(this.gatway);
  Future<bool> createBatch(BatchModel model){
    return gatway.createBatch(model); 
  }
   Future<bool> createAnnouncement(CreateAnnouncementModel model){
    return gatway.createAnnouncement(model); 
  }
}