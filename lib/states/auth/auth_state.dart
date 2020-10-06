import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/resources/exceptions/exceptions.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/states/auth/actor_model.dart';
import 'package:get_it/get_it.dart';

class AuthState extends ChangeNotifier{
  String email;
  String password;
  String mobile;

  set setEmail(String value){
    if(value.contains("@") || value.contains(".")){
      email = value;
      mobile = null;
    }else{
      mobile = value;
      email = null;;
    }
  }
  set setPassword(String value){
    password = value;
  }
  Future<bool> login()async{
    try{
      var model = ActorModel(
        email: email,
        password: password,
        mobile:mobile
      );
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
     return await repo.login(model);
    } on ApiException catch (error, strackTrace){
      
      final map = json.decode(error.message) as Map<String, dynamic>;
      ActorModel model = ActorModel.fromError(map);
      log("Login", error:error.message, stackTrace:strackTrace);
      throw(Exception( model.email ?? model.password ?? model.mobile));
    }
    catch (error, strackTrace){
      log("error", error:error, stackTrace:strackTrace);
      return false;
    }
  
  }
}