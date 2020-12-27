import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/ui/page/batch/batch_master_page.dart';
import 'package:flutter_pensil_app/ui/page/home/student_list_preview.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';

class BatchWidget extends StatelessWidget {
  const BatchWidget(
    this.model, {
    this.isTeacher = true,
    Key key,
  }) : super(key: key);
  final BatchModel model;
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: AppTheme.fullWidth(context) * .7,
      margin: EdgeInsets.only(left: 16),
      decoration: AppTheme.outline(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          if (model.subject != null)
            PChip(
              label: model.subject,
              backgroundColor: Color(0xffF67619),
              borderColor: Colors.transparent,
              style: theme.textTheme.bodyText1
                  .copyWith(fontSize: 14, color: theme.colorScheme.onSecondary),
            ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: Iterable.generate(model.classes.length, (index) {
                  final e = model.classes[index];
                  return Text(e.toshortDay() +
                          (model.classes.length == index + 1 ? "" : ","))
                      .hP4;
                }).toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StudentListPreview(list: model.studentModel),
            ],
          ),
        ],
      ).p16.ripple(() {
        Navigator.push(context,
            BatchMasterDetailPage.getRoute(model, isTeacher: isTeacher));
      }),
    );
  }
}
