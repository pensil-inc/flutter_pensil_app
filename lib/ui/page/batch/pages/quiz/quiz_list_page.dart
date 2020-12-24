import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/states/quiz/quiz_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/kit/overlay_loader.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/quiz/start/start_quiz.dart';
import 'package:flutter_pensil_app/ui/page/batch/widget/tile_action_widget.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class QuizListPage extends StatefulWidget {
  const QuizListPage({Key key, this.loader}) : super(key: key);
  final CustomLoader loader;

  @override
  _QuizListPageState createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  Widget _quizTile(AssignmentModel model) {
    return Container(
        decoration: AppTheme.decoration(context),
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(vertical: 8),
        // height: 50,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.list_alt).hP8.pT(4),
            Container(
              width: AppTheme.fullWidth(context) - 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: Theme.of(context).textTheme.subtitle2,
                    maxLines: 3,
                  ).vP4,
                  Text(
                    "Questions: ${model.questions}",
                    style: Theme.of(context).textTheme.subtitle2,
                    maxLines: 3,
                  ).vP4,
                  // Text(
                  //   "Subject: Englishhss",
                  //   style: Theme.of(context).textTheme.subtitle2,
                  //   maxLines: 3,
                  // ).vP4,
                  // Text(
                  //   "Time Alloted: ${model.duration} min",
                  //   style: Theme.of(context).textTheme.subtitle2,
                  //   maxLines: 3,
                  // ).vP4
                ],
              ),
            ).ripple(() {
              // if (Provider.of<HomeState>(context, listen: false).isTeacher) {
              //   return;
              // }
              Alert.dialog(
                context,
                title: model.title,
                buttonText: "Start Quiz",
                onPressed: () {
                  Navigator.pop(context);
                  final state = Provider.of<QuizState>(context, listen: false);
                  Navigator.push(
                      context,
                      StartQuizPage.getRoute(
                          model: model, batchId: state.batchId));
                },
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Images.quiz, height: 30).p(12),
                          Container(
                            width: AppTheme.fullWidth(context) - 138,
                            child: Text(model.title),
                          )
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Image.asset(Images.question, height: 30).p(12),
                          Text("${model.questions} questions"),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Image.asset(Images.timer, height: 30).p(12),
                          Text("${model.duration} Mins"),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
            if (Provider.of<HomeState>(context).isTeacher)
              TileActionWidget(
                list: ["Delete"],
                onDelete: () => deleteQuiz(model.id),
                onEdit: () {},
              ),
            // SizedBox(width: 12),
          ],
        ));
  }

  void deleteQuiz(String id) {
    Alert.yesOrNo(context,
        message: "Are you sure, you want to delete this Quiz ?",
        title: "Message",
        barrierDismissible: true,
        onCancel: () {}, onYes: () async {
      widget.loader.showLoader(context);
      final isDeleted =
          await Provider.of<QuizState>(context, listen: false).deleteQuiz(id);
      if (isDeleted) {
        Utility.displaySnackbar(context, msg: "Quiz Deleted");
      }
      widget.loader.hideLoader();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizState>(
      builder: (context, state, child) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemCount: state.assignmentsList.length,
          itemBuilder: (_, index) {
            return _quizTile(state.assignmentsList[index]);
          },
        );
      },
    );
  }
}
