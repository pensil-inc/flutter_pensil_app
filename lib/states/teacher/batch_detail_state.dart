import 'package:flutter_pensil_app/model/batch_timeline_model.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:flutter_pensil_app/states/base_state.dart';

class BatchDetailState extends BaseState {
  final String batchId;
  List<BatchTimeline> timeLineList;

  BatchDetailState({this.batchId});

  Future getBatchTimeLine() async {
    await execute(() async {
      isBusy = true;
      final repo = getit.get<BatchRepository>();
      timeLineList = await repo.getBatchDetailTimeLine(batchId);
      notifyListeners();
      isBusy = false;
    }, label: "getBatchTimeLine");
  }
}
