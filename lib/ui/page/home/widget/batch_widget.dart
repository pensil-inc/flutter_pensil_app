import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/ui/page/home/student_list_preview.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';

class BatchWidget extends StatelessWidget {
  const BatchWidget(
    this.model, {
    Key key,
  }) : super(key: key);
  final BatchModel model;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: AppTheme.decoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.name, style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          PChip(
            label: model.subject,
            backgroundColor: Color(0xffF67619),
            borderColor: Colors.transparent,
            style: theme.textTheme.bodyText1.copyWith(fontSize: 14, color: theme.colorScheme.onSecondary),
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Row(
                children: Iterable.generate(model.classes.length, (index) {
                  final e = model.classes[index];
                  return Text(e.toshortDay() + (model.classes.length == index + 1 ? "" : ",")).hP4;
                }).toList(),
              ),
              Spacer(),
              StudentListPreview(list: model.studentModel),
            ],
          )
        ],
      ),
    );
  }
}
