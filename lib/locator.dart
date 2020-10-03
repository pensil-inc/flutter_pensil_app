import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_pensil_app/config/config.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway_impl.dart';
import 'package:flutter_pensil_app/resources/service/dio_client.dart';
import 'package:get_it/get_it.dart';

void setUpDependency(Config config) {
  final serviceLocator = GetIt.instance;

  String localeName = Platform.localeName ?? "ar_AR";

  // serviceLocator.registerSingleton<ErrorsProducer>(ErrorsProducer());

  serviceLocator.registerSingleton<ApiGateway>(
    ApiGatewayImpl(
      DioClient(Dio(), baseEndpoint: config.apiBaseUrl, logging: true),
    ),
  );
  serviceLocator.registerSingleton(BatchRepository(ApiGatewayImpl(
    DioClient(Dio(), baseEndpoint: config.apiBaseUrl, logging: true),
  )));
  // serviceLocator.registerSingleton<AuthState>(AuthState());
  // serviceLocator
  //     .registerSingleton<SharedPrefrenceHelper>(SharedPrefrenceHelper());
}
