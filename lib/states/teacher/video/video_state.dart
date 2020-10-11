import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:get_it/get_it.dart';

class VideoState extends ChangeNotifier{
  String yUrl;
  String yTitle;
  String subject;
  void setUrl(String url, String title){
    yUrl = url;
     yTitle = title;
    notifyListeners();
  }
  set setSubject(String value){
    subject = value;
    notifyListeners();
  }
  Future<bool> addVideo(String title, String description)async{
     try{
      assert(title != null);
      var model = VideoModel(
        title:title,
        description:description,
        subject: "Physics",
        url: yUrl
      );
      final getit = GetIt.instance;
      final repo = getit.get<TeacherRepository>();
      await repo.addVideo(model);
      return true;
    }catch (error, strackTrace){
      log("createBatch", error:error, stackTrace:strackTrace);
      return null;
    }
  }
}