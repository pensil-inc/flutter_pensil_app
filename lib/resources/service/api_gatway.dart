import 'package:flutter_pensil_app/model/batch_model.dart';

abstract class ApiGateway {
  Future<dynamic> getUser();
  Future<dynamic> createBatch(BatchModel model);
}