import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget( this.model,{Key key,}) : super(key: key);
  final AnnouncementModel model;
  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: AppTheme.decoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.description),
          // Wrap(
          //   children:model.batches.map((e) => PChip(
          //     label:e
          //   )).toList()
          // ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
                Utility.getPassedTime(model.createdAt.toIso8601String()),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}