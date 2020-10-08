import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/ui/theme/light_color.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class PollWidget extends StatelessWidget {
  const PollWidget({Key key, this.model}) : super(key: key);
  final PollModel model;
  Widget _secondaryButton(BuildContext context,
      {String label, Function onPressed}) {
    final theme = Theme.of(context);
    return OutlineButton(
        onPressed: onPressed,
        textColor: Theme.of(context).primaryColor,
        highlightedBorderColor: Theme.of(context).primaryColor,
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Text(
          label,
          style: theme.textTheme.button
              .copyWith(color: PColors.primary, fontWeight: FontWeight.bold),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: AppTheme.decoration(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(model.question),
            SizedBox(height: 10),
            Column(
              children:model.options.map((e) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: EdgeInsets.only(top:5),
                  decoration:AppTheme.outlinePrimary(context),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(e),
                      Text("45%"),
                    ]
                  )
                );
              }).toList()
            ),
            SizedBox(height: 10),
            _secondaryButton(context, label: "Finish", onPressed: () {})
          ],
        ));
  }
}
