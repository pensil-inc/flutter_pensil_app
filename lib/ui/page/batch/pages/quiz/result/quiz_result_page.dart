import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/quiz/result/view_quiz_solution.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';

class QuizRasultPage extends StatelessWidget {
  const QuizRasultPage({Key key, this.model, this.timeTaken}) : super(key: key);
  final QuizDetailModel model;
  final String timeTaken;
  static MaterialPageRoute getRoute({QuizDetailModel model, String batchId, String timeTaken}) {
    return MaterialPageRoute(builder: (_) => QuizRasultPage(model: model, timeTaken: timeTaken));
  }

  Widget _secondaryButton(BuildContext context, String img, String title, String subtitle) {
    return Container(
      width: (AppTheme.fullWidth(context) - 48) * .5,
      height: 140,
      decoration: AppTheme.decoration(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img, height: 20),
          Text(title).vP8,
          Text(subtitle, style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    final total = model.questions.length;
    final correct = model.questions.where((e) => e.answer == e.selectedAnswer).length;
    final wrong = model.questions.where((e) => e.answer != e.selectedAnswer).length;
    final skipped = model.questions.where((e) => e.selectedAnswer == null).length;

    final percent = correct * 100 / total;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF7506A),
        leading: SizedBox(),
        title: Text("Result", style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 26),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    Images.scoreBack,
                    width: AppTheme.fullWidth(context) * .5,
                  ),
                  Column(
                    children: [
                      Text("Score", style: Theme.of(context).textTheme.headline6).vP8,
                      Text("$percent %", style: Theme.of(context).textTheme.headline5),
                    ],
                  )
                ],
              ),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _secondaryButton(context, Images.correct, "Correct", "$correct/$total"),
                  SizedBox(width: 16),
                  _secondaryButton(context, Images.wrong, "Wrong", "$wrong/$total"),
                ],
              ).vP8,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _secondaryButton(context, Images.skipped, "Skipped", "$skipped/$total"),
                  SizedBox(width: 16),
                  _secondaryButton(context, Images.timer, "Time taken", timeTaken),
                ],
              ).vP8,
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: AppTheme.outlinePrimary(context),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "View Solution",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                ),
              ).ripple(() {
                Navigator.push(context, QuizSolutionPage.getRoute(model));
              }),
              SizedBox(height: 16),
              PFlatButton(
                label: "Go to home",
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
