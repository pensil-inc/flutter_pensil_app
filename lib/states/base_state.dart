import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/resources/repository/batch_repository.dart';
import 'package:get_it/get_it.dart';

class BaseState extends ChangeNotifier {
  bool _isBusy = false;
  final getit = GetIt.instance;
  bool get isBusy => _isBusy;

  set isBusy(bool val) {
    _isBusy = val;
    notifyListeners();
  }

  Future<T> execute<T>(Future<T> Function() handler,
      {String label = "Error"}) async {
    try {
      return await handler();
    } catch (error, strackTrace) {
      log(label, error: error, stackTrace: strackTrace);
      return null;
    }
  }

  /// in `idAndType` param pass resource id and its type
  ///
  /// For example to delete a video pass `video/sdfsdf9878sd7f87sd7f89dfsd` as paramter.
  Future<bool> deleteById(String idAndType, {String label = "Delete"}) async {
    try {
      final repo = getit.get<BatchRepository>();
      var isDeleted = await repo.deleteById(idAndType);
      return isDeleted;
    } catch (error) {
      log(label, error: error, name: this.runtimeType.toString());
      return false;
    }
  }
}
