import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/helper/shared_prefrence_helper.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway_impl.dart';
import 'package:flutter_pensil_app/resources/service/dio_client.dart';
import 'package:flutter_pensil_app/resources/service/notification_service.dart';
import 'package:flutter_pensil_app/resources/service/session/session.dart';
import 'package:flutter_pensil_app/resources/service/session/session_impl.dart';
import 'package:get_it/get_it.dart';

void setUpDependency(Config config) {
  final serviceLocator = GetIt.instance;

  // serviceLocator.registerSingleton<ErrorsProducer>(ErrorsProducer());
  serviceLocator.registerSingleton<SharedPrefrenceHelper>(SharedPrefrenceHelper());
  serviceLocator.registerSingleton(NotificationService(FirebaseMessaging()));

  /// Initilise nitificaion plugin
  final notifcationService = serviceLocator<NotificationService>();
    notifcationService.initializeMessages();
    notifcationService.configure();

  serviceLocator.registerSingleton<ApiGateway>(
    ApiGatewayImpl(
      DioClient(Dio(), baseEndpoint: config.apiBaseUrl, logging: true),
      pref:GetIt.instance<SharedPrefrenceHelper>(),
    ),
  );
  serviceLocator.registerFactory<SessionService>(
    () => SessionServiceImpl(
      GetIt.instance<ApiGateway>(),
      GetIt.instance<SharedPrefrenceHelper>(),
    ),
  );
  serviceLocator.registerSingleton(BatchRepository(
    GetIt.instance<ApiGateway>(),
    GetIt.instance<SessionService>(),
  ));
  serviceLocator.registerSingleton(TeacherRepository(
    GetIt.instance<ApiGateway>(),
    GetIt.instance<SessionService>(),
  ));
}
