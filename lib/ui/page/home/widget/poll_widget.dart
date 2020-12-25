import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/poll_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/ui/kit/overlay_loader.dart';
import 'package:flutter_pensil_app/ui/page/batch/widget/tile_action_widget.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class PollWidget extends StatelessWidget {
  const PollWidget(
      {Key key, this.model, this.loader, this.hideFinishButton = true})
      : super(key: key);
  final PollModel model;
  final CustomLoader loader;
  final bool hideFinishButton;

  Widget _secondaryButton(BuildContext context,
      {String label, Function onPressed, bool isLoading = false}) {
    final theme = Theme.of(context);
    return OutlineButton(
      onPressed: isLoading ? null : onPressed,
      textColor: Theme.of(context).primaryColor,
      highlightedBorderColor: Theme.of(context).primaryColor,
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: isLoading
          ? SizedBox(
              height: 25,
              width: 25,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            )
          : Text(
              label,
              style: theme.textTheme.button.copyWith(
                  color: PColors.primary, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _option(BuildContext context, String e) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: model.selection.choice == e
            ? AppTheme.outlineSucess(context)
                .copyWith(color: PColors.green.withOpacity(.3))
            : model.isMyVote(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(e).extended,
            Text(model.percent(e).toStringAsFixed(1) + "%"),
          ],
        ),
      ).ripple(() {
        final state = Provider.of<HomeState>(context, listen: false);

        /// Teacher cannot vote
        /// If user already submitted his vote and api is calling
        /// If poll is expired then student cannot cast his vote
        if (state.isTeacher ||
            model.selection.loading ||
            model.endTime.isBefore(DateTime.now())) {
          return;
        }

        //Restrict user to vote more then 1 time
        final userId = Provider.of<HomeState>(context, listen: false).userId;
        if (model.isVoted(userId)) {
          print("Already voted");
          return;
        }
        model.selection = MySelection(choice: e, isSelected: true);
        state.savePollSelection(model);
      }),
    );
  }

  void submitVote(context, String answer) {
    ///Restrict user to tap repeatatively to submit vote
    final state = Provider.of<HomeState>(context, listen: false);
    if (state.isBusy) {
      return;
    }

    state.castVoteOnPoll(model, answer);
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeState>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: AppTheme.decoration(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(model.question).pL(16).extended,
              if (context.watch<HomeState>().isTeacher)
                TileActionWidget(
                  list: ["End Poll", "Delete"],
                  // End poll method
                  onCustomIconPressed: () async {
                    loader.showLoader(context);
                    await context.read<HomeState>().expirePoll(model.id);
                    loader.hideLoader();
                  },
                  onDelete: () async {
                    loader.showLoader(context);
                    await context.read<HomeState>().deletePoll(model.id);
                    loader.hideLoader();
                  },
                )
              else
                SizedBox(width: 16)
            ],
          ),
          SizedBox(height: 10),
          Column(
              children: model.options.map((e) {
            return _option(context, e).hP16;
          }).toList()),

          /// Restrict user to vote If
          /// He is a teacher
          /// He is already Voted
          /// Poll is exired
          if (!state.isTeacher &&
              !model.isVoted(state.userId) &&
              model.selection.isSelected &&
              !model.endTime.isBefore(DateTime.now())) ...[
            SizedBox(height: 10),
            _secondaryButton(context,
                isLoading: model.selection.loading,
                label: "Submit", onPressed: () {
              submitVote(context, model.selection.choice);
            })
          ],
          SizedBox(height: 16)
        ],
      ),
    );
  }
}
