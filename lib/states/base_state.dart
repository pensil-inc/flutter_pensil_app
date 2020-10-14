import 'dart:developer';

import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  bool _isBusy = false;

  bool get isBusy => _isBusy;

  set isBusy(bool val) {
    _isBusy = val;
    notifyListeners();
  }

  Future<T> execute<T>(Future<T> Function() handler,{String label = "Error"}) async {
    try {
      return await handler();
    } catch (error, strackTrace) {
      log(label,error: error, stackTrace: strackTrace);
      return null;
    }
  }
}
