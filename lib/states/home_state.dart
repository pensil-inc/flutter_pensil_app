import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:get_it/get_it.dart';

class HomeState extends ChangeNotifier {
 
  List<BatchModel> batchList;

  Future getBatchList(){
    try{
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
    }catch(error,strackTrace){
      log("createBatch", error:error, stackTrace:strackTrace);
    }
  }
}