import 'dart:async';

import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';
import 'package:get_it/get_it.dart';

class QuizState extends BaseState {
  QuizState({this.batchId}) {
    print("Create State instance");
  }
  final String batchId;
  List<AssignmentModel> assignmentsList;

  QuizDetailModel quizModel ;//= QuizDetailModel.dummyData;

  void addAnswer(Question value) {
    var data = quizModel.questions.firstWhere((element) => element.id == value.id);
    data.selectedAnswer = value.selectedAnswer;
    notifyListeners();
  }

  Future getQuizList() async {
    await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      assignmentsList = await repo.getAssignmentList(batchId);
      notifyListeners();
      isBusy = false;
    }, label: "getQuizList");
  }

  Future<QuizDetailModel> getAssignmentDetail(String assignmentId) async {
    await execute(() async {
      isBusy = true;
      final getit = GetIt.instance;
      final repo = getit.get<BatchRepository>();
      quizModel = await repo.getAssignmentDetailList(batchId, assignmentId);
      isBusy = false;
      return quizModel;
    }, label: "getAssignmentDetail");
  }
}
