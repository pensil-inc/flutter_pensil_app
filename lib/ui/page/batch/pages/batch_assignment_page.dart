import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class BatchAssignmentPage extends StatelessWidget {
  const BatchAssignmentPage({Key key, this.model}) : super(key: key);
  final BatchModel model;
  static MaterialPageRoute getRoute(BatchModel model) {
    return MaterialPageRoute(
        builder: (_) => BatchAssignmentPage(
              model: model,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: AppTheme.fullWidth(context),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Nothing  to see here",
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: PColors.gray,
                  )),
          SizedBox(height: 10),
          Text("No Assignment is uploaded yet for this batch!!", style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
