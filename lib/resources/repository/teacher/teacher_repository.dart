import 'dart:io';

import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/session/session.dart';

class TeacherRepository {
  final ApiGateway gatway;
  final SessionService sessionService;
  TeacherRepository(this.gatway,this.sessionService);

  Future<bool> createPoll(PollModel model)async{
    return gatway.createPoll(model);
  }
  Future<bool> addVideo(VideoModel model){
    return gatway.addVideo(model); 
  }

  Future<String> uploadFile(File file){
    return gatway.uploadFile(file);
  }
}