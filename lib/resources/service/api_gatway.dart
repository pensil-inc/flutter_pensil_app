import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/states/create_announcement_model.dart';

abstract class ApiGateway {
  Future<dynamic> getUser();
  Future<bool> createBatch(BatchModel model);
  Future<bool> createAnnouncement(CreateAnnouncementModel model);
}