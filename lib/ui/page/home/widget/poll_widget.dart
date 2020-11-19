import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/states/auth/auth_state.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class PollWidget extends StatelessWidget {
  const PollWidget({Key key, this.model, this.hideFinishButton = true})
      : super(key: key);
  final PollModel model;
  final bool hideFinishButton;

  Widget _secondaryButton(BuildContext context,
      {String label, Function onPressed}) {
    final theme = Theme.of(context);
    return OutlineButton(
        onPressed: onPressed,
        textColor: Theme.of(context).primaryColor,
        highlightedBorderColor: Theme.of(context).primaryColor,
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Text(
          label,
          style: theme.textTheme.button
              .copyWith(color: PColors.primary, fontWeight: FontWeight.bold),
        ));
  }

  Widget _option(BuildContext context, String e) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: model.isMyVote(
                Provider.of<HomeState>(
                  context,
                ).userId,
                e)
            ? AppTheme.outlineSucess(context)
                .copyWith(color: PColors.green.withOpacity(.3))
            : model.endTime.isAfter(DateTime.now())
                ? AppTheme.outlinePrimary(context)
                : AppTheme.outline(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(e),
            Text(model.percent(e).toStringAsFixed(1) + "%"),
          ],
        ),
      ).ripple(() {
        submitVote(context, e);
      }),
    );
  }

  void submitVote(context, String answer) {
    if (model.isMyVote(
        Provider.of<HomeState>(context, listen: false).userId, answer)) {
      print("Already voted");
      return;
    }
    final state = Provider.of<HomeState>(context, listen: false);
    if (state.isBusy) {
      return;
    }
    if (!model.endTime.isBefore(DateTime.now())) {
      state.castVoteOnPoll(model.id, answer);
    }
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
              children: model.options.map((e) {
            return _option(context, e);
          }).toList()),
          if (hideFinishButton) ...[
            SizedBox(height: 10),
            _secondaryButton(context, label: "Finish", onPressed: () {})
          ]
        ],
      ),
    );
  }
}
