import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/states/quiz/quiz_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/quiz/start/start_quiz.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class QuizListPage extends StatefulWidget {
  const QuizListPage({Key key}) : super(key: key);

  @override
  _QuizListPageState createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  Widget _quizTile(AssignmentModel model) {
    return Container(
      decoration: AppTheme.decoration(context),
      margin: EdgeInsets.only(bottom: 12),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.title,
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 3,
                      ),
                      // Text(model.description,style: Theme.of(context).textTheme.bodyText2,maxLines: 2, ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ).ripple(() {
        // Utility.displaySnackbar(context,);
        Alert.dialog(
          context,
          title: "Test",
          buttonText: "Start Quiz",
          onPressed: () {
            Navigator.pop(context);
            final state = Provider.of<QuizState>(context, listen: false);
            Navigator.push(context, StartQuizPage.getRoute(model: model, batchId: state.batchId));
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
    );
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
