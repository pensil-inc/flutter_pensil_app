import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/actor_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/batch_time_slot_model.dart';
import 'package:flutter_pensil_app/model/subject.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/resources/repository/teacher/teacher_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class CreateBatchStates extends BaseState {
  CreateBatchStates(BatchModel model) {
    setBatchToEdit(model);
  }
  final getit = GetIt.instance;
  String batchName = "";
  String description;
  bool isEditBatch = false;
  String selectedSubjects;

  BatchModel editBatch = BatchModel();

  setBatchToEdit(BatchModel model) {
    if (model == null) {
      return;
    }
    isEditBatch = true;
    editBatch = model;
    selectedStudentsList = model.studentModel;
    batchName = model.name;
    timeSlots = List.from(model.classes);
    description = model.description;
    var counter = 0;
    timeSlots.forEach((clas) {
      clas.index = counter;
      counter++;
      clas.key = UniqueKey().toString();
    });
    selectedSubjects = model.subject;
    selectedStudentsList.forEach((model) {
      print(model.id);
    });
  }

  List<Subject> availableSubjects;

  List<String> contactList;

  /// selected student's mobile list from availavle students
  List<BatchTimeSlotModel> timeSlots = [BatchTimeSlotModel.initial()];

  /// Total available previous students list from api
  List<ActorModel> studentsList;

  /// List of students selected from Total avilable students list
  List<ActorModel> selectedStudentsList;
  set setBatchName(String value) {
    batchName = value;
  }

  set setBatchdescription(String value) {
    description = value;
  }

  void setTimeSlots(BatchTimeSlotModel model) {
    if (timeSlots == null) timeSlots = List<BatchTimeSlotModel>();
    model.index = timeSlots.length;
    timeSlots.add(model);
    notifyListeners();
  }

  bool removeTimeSlot(BatchTimeSlotModel model) {
    if (timeSlots.length == 1) {
      return false;
    }
    timeSlots.removeWhere((element) => element.key == model.key);
    timeSlots.forEach((element) {
      element.index = timeSlots.indexOf(element);
    });
    // timeSlots.add(model);
    notifyListeners();
    return true;
  }

  set setSelectedSubjects(String name) {
    var model = availableSubjects.firstWhere((element) => element.name == name);
    availableSubjects.forEach((element) {
      element.isSelected = false;
    });
    model.isSelected = true;
    selectedSubjects = name;
    notifyListeners();
  }

  void updateTimeSlots(BatchTimeSlotModel model, int index) {
    var data = timeSlots[index];
    data = model;
    checkSlotsModel(model);
    notifyListeners();
  }

  void addContact(String mobile) {
    if (contactList == null) {
      contactList = [];
    }
    contactList.add(mobile);
    notifyListeners();
  }

  void removeContact(String mobile) {
    contactList.remove(mobile);
    notifyListeners();
  }

  /// Add stuent mobile no. from available list
  set setStudentsFromList(ActorModel value) {
    if (selectedStudentsList == null) {
      selectedStudentsList = [];
    }
    var model = studentsList
        .firstWhere((e) => e.name == value.name && e.mobile == value.mobile);
    model.isSelected = true;
    // selectedStudentsList.add(model);
    notifyListeners();
  }

  void removeStudentFromList(value) {
    var model = studentsList
        .firstWhere((e) => e.name == value.name && e.mobile == value.mobile);
    model.isSelected = false;
    notifyListeners();
  }

  void addNewSubject(String value) {
    if (availableSubjects == null) {
      availableSubjects = List<Subject>()
        ..add(Subject(index: 0, name: value, isSelected: true));
    } else {
      availableSubjects.add(Subject(
          index: availableSubjects.length, name: value, isSelected: false));
    }
    notifyListeners();
  }

  bool checkSlotsVAlidations() {
    bool allGood = true;
    timeSlots.forEach((model) {
      checkSlotsModel(model);
    });
    notifyListeners();
    return allGood;
  }

  void checkSlotsModel(BatchTimeSlotModel model) {
    if (model.startTime == "Start time") {
      model.isValidStartEntry = false;
    } else {
      model.isValidStartEntry = true;
    }
    if (model.endTime == "End time") {
      model.isValidEndEntry = false;
    } else {
      model.isValidEndEntry = true;
    }
  }

  /// Create batch by calling api
  Future<BatchModel> createBatch() async {
    try {
      final mobile = studentsList
          .where((element) => element.isSelected)
          .map((e) => e.mobile);
      List<String> contacts = new List.from(contactList ?? List<String>())
        ..addAll(mobile ?? List<String>());
      final model = editBatch.copyWith(
          name: batchName,
          description: description,
          classes: timeSlots,
          subject: selectedSubjects,
          students: contacts);
      // print(model.toJson());
      final repo = getit.get<BatchRepository>();
      await repo.createBatch(model);
      // timeSlots.forEach((e) => print(e.toJson()));
      // return Future.value(null);
      return model;
    } catch (error, strackTrace) {
      log("createBatch", error: error, stackTrace: strackTrace);
      return null;
    }
  }

  Future getStudentList() async {
    try {
      final repo = getit.get<TeacherRepository>();
      studentsList = await repo.getStudentList();
      if (studentsList != null && studentsList.isNotEmpty) {
        studentsList.removeWhere((element) => element.mobile == null);
        studentsList.toSet().toList();
        final ids = studentsList.map((e) => e.mobile).toSet();
        studentsList.retainWhere((x) => ids.remove(x.mobile));
        if (selectedStudentsList != null && selectedStudentsList.isNotEmpty) {
          studentsList.forEach((student) {
            var isAvailable =
                selectedStudentsList.any((element) => student.id == element.id);
            print(student.id);
            student.isSelected = isAvailable;
          });
        }
      }

      await getSubjectList();
      notifyListeners();
    } catch (error, strackTrace) {
      log("getStudentList", error: error, stackTrace: strackTrace);
      return null;
    }
  }

  Future getSubjectList() async {
    await execute(() async {
      final repo = getit.get<TeacherRepository>();
      final list = await repo.getSubjectList();
      if (list != null) {
        /// Remove duplicate subjects
        list.toSet().toList();
        final ids = list.map((e) => e).toSet();
        list.retainWhere((x) => ids.remove(x));

        availableSubjects = Iterable.generate(
          list.length,
          (index) => Subject(
            index: index,
            name: list[index],
            isSelected: selectedSubjects == null
                ? index == 0
                : selectedSubjects == list[index]
                    ? true
                    : false,
          ),
        ).toList();

        if (selectedSubjects == null) {
          selectedSubjects = availableSubjects.first.name;
        }
      }
    }, label: "Get Sybjects");
  }
}
