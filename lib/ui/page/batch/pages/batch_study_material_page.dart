import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';

class BatchStudyMaterialPage extends StatelessWidget {
  const BatchStudyMaterialPage({Key key, this.model}) : super(key: key);
  final BatchModel model;
  static MaterialPageRoute getRoute(BatchModel model) {
    return MaterialPageRoute(
        builder: (_) => BatchStudyMaterialPage(
              model: model,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
