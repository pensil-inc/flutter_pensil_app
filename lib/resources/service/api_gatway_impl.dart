import 'package:dio/dio.dart';
import 'package:flutter_pensil_app/helper/constants.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';
import 'package:flutter_pensil_app/resources/service/dio_client.dart';
import 'package:flutter_pensil_app/states/create_announcement_model.dart';

class ApiGatewayImpl implements ApiGateway {
  final DioClient _dioClient;

  ApiGatewayImpl(this._dioClient);

  @override
  Future getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> createBatch(BatchModel model) async {
    try {
      final data = model.toJson();
      print(data);
      String token = Constants.token;
      final header = {"Authorization": "Bearer " + token};
      var response = await _dioClient.post(Constants.createBatch,
          data: data, options: Options(headers: header));
      return true;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<bool> createAnnouncement(CreateAnnouncementModel model) async {
    try {
      final data = model.toJson();
      String token = Constants.token;
      final header = {"Authorization": "Bearer " + token};
      var response = await _dioClient.post(Constants.createAnnouncement,
          data: data, options: Options(headers: header));
      return true;
    } catch (error) {
      throw error;
    }
  }
}
