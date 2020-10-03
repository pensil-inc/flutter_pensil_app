import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/batch_time_slot_model.dart';
import 'package:flutter_pensil_app/model/student_model.dart';
import 'package:flutter_pensil_app/model/subject.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:get_it/get_it.dart';

class CreateBatchStates extends ChangeNotifier {
  String batchName;
  String description;
  // List<String> availableSubjects;
  String selectedSubjects;
  List<Subject> availableSubjects = [
    Subject(name: "Philosophy", index: 0),
    Subject(name: "General Studies", index: 1),
    Subject(name: "Geography", index: 2),
  ];

  List<String> contactList;

  /// selected student's contact list from availavle students
  List<String> selectedStudentsListTemp;
  List<BatchTimeSlotModel> timeSlots;

  /// Total available previous students list from api
  List<StudentModel> studentsList = StudentModel.dummyList();

  /// List of students selected from Total avilable students list
  List<StudentModel> selectedStudentsList;
  set setBatchName(String value){
    batchName = value; 
  }
  set setBatchdescription(String value){
    description = value; 
  }
  void setTimeSlots(BatchTimeSlotModel model) {
    if (timeSlots == null) timeSlots = List<BatchTimeSlotModel>();
    model.index = timeSlots.length + 1;
    timeSlots.add(model);
    notifyListeners();
  }

  set setSelectedSubjects(String name) {
   
    var model = availableSubjects.firstWhere((element) => element.name == name);
    availableSubjects.forEach((element) {
      element.isSelected = false;
    });
    model.isSelected = true;
    // if (model.isSelected) {
    //   model.isSelected = false;
      
    // } else {
    //   model.isSelected = true;
    // }
    selectedSubjects = name;
    notifyListeners();
  }

  void updateTimeSlots(BatchTimeSlotModel model) {
    var data = timeSlots.firstWhere((e) => e.index == e.index);
    data = model;
    notifyListeners();
  }

  void addContact(String contact) {
    if (contactList == null) {
      contactList = [];
    }
    contactList.add(contact);
    notifyListeners();
  }

  void removeContact(String contact) {
    contactList.remove(contact);
    notifyListeners();
  }

  set setStudentsFromList(List<String> contacts) {
    if (selectedStudentsList == null) {
      selectedStudentsList = [];
      selectedStudentsListTemp = [];
    }
    selectedStudentsList.clear();
    selectedStudentsListTemp.clear();
    contacts.forEach((name) {
      var model = studentsList.firstWhere((element) => element.name == name);
      selectedStudentsList.add(model);
      selectedStudentsListTemp.add(model.contact);
    });
    notifyListeners();
  }

  Future<Null> createBatch() async {
    try {
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      final model = BatchModel(
          name: batchName,
          description: description,
          classes: timeSlots,
          subject: selectedSubjects,
          students: [...contactList, ...selectedStudentsListTemp]);
          // print(model.toJson());
      await repo.createBatch(model);
    } catch (error, strackTrace){
      log("createBatch", error:error, stackTrace:strackTrace);
    }
  }
}
