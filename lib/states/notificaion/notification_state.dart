import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/model/notification_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:get_it/get_it.dart';

class NotificationState extends ChangeNotifier{
  List<NotificationModel> notifications;
  bool isLoading = false;
  
  Future getNotifications()async{
    try{
      isLoading = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      notifications = await repo.getStudentNotificationsList();
      if(notifications != null && notifications.isNotEmpty){
        notifications.sort((a,b) => b.createdAt.compareTo(a.createdAt));
      }
    }catch (error, strackTrace){
      log("getNotifications", error:error, stackTrace:strackTrace);
    }
    isLoading = false;
    notifyListeners();
  }
}