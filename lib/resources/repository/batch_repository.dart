import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/resources/service/api_gatway.dart';

class BatchRepository {
  final ApiGateway gatway;

  BatchRepository(this.gatway);
  Future<dynamic> createBatch(BatchModel model){
    return gatway.createBatch(model); 
  }
}