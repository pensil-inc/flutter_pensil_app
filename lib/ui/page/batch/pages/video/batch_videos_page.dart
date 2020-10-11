import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';

class BatchVideosPage extends StatelessWidget {
  const BatchVideosPage({Key key, this.model}) : super(key: key);
  final BatchModel model;
  static MaterialPageRoute getRoute(BatchModel model) {
    return MaterialPageRoute(
        builder: (_) => BatchVideosPage(
              model: model,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
