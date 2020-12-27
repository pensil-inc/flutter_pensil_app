import 'dart:io';

import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/session/session.dart';

class TeacherRepository {
  final ApiGateway gatway;
  final SessionService sessionService;
  final SharedPrefrenceHelper pref;
  TeacherRepository(this.gatway, this.sessionService, this.pref);

  Future<List<String>> getSubjectList() async {
    // final list = await pref.getSubjects();
    //   if(list != null){
    //     return list.subjects;
    //   }
    return gatway.getSubjectList();
  }

  Future<List<ActorModel>> getStudentList() async {
    //  final list = await pref.getStudents();
    //     if(list != null){
    //       return list.students;
    //     }
    return gatway.getStudentList();
  }

  Future<bool> createPoll(PollModel model) async {
    return gatway.createPoll(model);
  }

  Future<bool> expirePollById(String pollId) {
    return gatway.expirePollById(pollId);
  }

  Future<VideoModel> addVideo(VideoModel model, {bool isEdit}) {
    return gatway.addVideo(model, isEdit: isEdit);
  }

  Future<bool> uploadFile(File file, String id, {String endpoint}) {
    return gatway.uploadFile(file, id, endpoint: endpoint);
  }

  Future<BatchMaterialModel> uploadMaterial(BatchMaterialModel model,
      {bool isEdit}) {
    return gatway.uploadMaterial(model, isEdit: isEdit);
  }
}
