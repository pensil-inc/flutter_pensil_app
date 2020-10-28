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
  TeacherRepository(this.gatway,this.sessionService, this.pref);
  
  Future<List<String>> getSubjectList()async{
    // final list = await pref.getSubjects();
    //   if(list != null){
    //     return list.subjects;
    //   }
    return gatway.getSubjectList();
  }
 Future<List<ActorModel>> getStudentList()async{
  //  final list = await pref.getStudents();
  //     if(list != null){
  //       return list.students;
  //     }
     return gatway.getStudentList();
  }
  Future<bool> createPoll(PollModel model)async{
    return gatway.createPoll(model);
  }
  Future<VideoModel> addVideo(VideoModel model){
    return gatway.addVideo(model); 
  }

  Future<bool> uploadFile(File file,String id,{bool isVideo = false}){
    return gatway.uploadFile(file,id,isVideo:isVideo);
  }
  Future<BatchMaterialModel> uploadMaterial(BatchMaterialModel model){
    return gatway.uploadMaterial(model);
  }
}