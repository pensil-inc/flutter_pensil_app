import 'dart:convert';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/model/subject.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceHelper {
  SharedPrefrenceHelper._internal();
  static final SharedPrefrenceHelper _singleton =
      SharedPrefrenceHelper._internal();

  factory SharedPrefrenceHelper() {
    return _singleton;
  }
  Future<bool> setAccessToken(String value) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.AccesssToken.toString(), value);
  }

  Future<String> getAccessToken() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.AccesssToken.toString());
  }

  Future<bool> setUserName(String value) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.UserName.toString(), value);
  }

  Future<String> getUserName() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserName.toString());
  }

  Future<Null> cleaPrefrenceValues()async{
    await (SharedPreferences.getInstance())..clear();
  }
  Future<void> saveUserProfile(ActorModel user) async {
   return (await SharedPreferences.getInstance())
         .setString(UserPreferenceKey.UserProfile.toString(),json.encode(user.toJson()));
  }
  
  Future<ActorModel> getUserProfile() async {
    final jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserProfile.toString());
    return ActorModel.fromJson(json.decode(jsonString));
  }
  Future<bool> isStudent() async {
    final jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserProfile.toString());
    return ActorModel.fromJson(json.decode(jsonString)).isStudent;
  }
  Future<void> saveSubjects(SubjectReponseModel model) async {
   return (await SharedPreferences.getInstance())
         .setString(UserPreferenceKey.Subjects.toString(),json.encode(model.toJson()));
  }
  Future<SubjectReponseModel> getSubjects() async {
    final jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.Subjects.toString());
    if(jsonString == null){
      return null;
    }
    return SubjectReponseModel.fromJson(json.decode(jsonString));
  }
  
  Future<void> saveStudent(StudentResponseModel model) async {
   return (await SharedPreferences.getInstance())
         .setString(UserPreferenceKey.Students.toString(),json.encode(model.toJson()));
  }
  Future<StudentResponseModel> getStudents() async {
    final jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.Students.toString());
    if(jsonString == null){
      return null;
    }
    return StudentResponseModel.fromJson(json.decode(jsonString));
  }
}

enum UserPreferenceKey {
  LanguageCode,
  CountryISOCode,
  AccesssToken,
  UserProfile,
  UserName,
  Subjects,
  Students
}
