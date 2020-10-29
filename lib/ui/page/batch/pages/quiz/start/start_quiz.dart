import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/states/quiz/quiz_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/quiz/quiz_result_page.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/quiz/start/widget/question_count_section.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/quiz/start/widget/timer.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:provider/provider.dart';

class StartQuizPage extends StatefulWidget {
  StartQuizPage({Key key, this.model}) : super(key: key);
  final AssignmentModel model;
  static MaterialPageRoute getRoute({AssignmentModel model, String batchId}) {
    return MaterialPageRoute(
        builder: (_) => Provider(
              create: (_) => QuizState(),
              child: ChangeNotifierProvider<QuizState>(
                  create: (_) => QuizState(batchId: batchId),
                  child: StartQuizPage(
                    model: model,
                  ),
                  builder: (_, child) => child),
            ));
  }

  @override
  _StartQuizPageState createState() => _StartQuizPageState();
}

class _StartQuizPageState extends State<StartQuizPage> {
  ValueNotifier<bool> isDisplayQuestion = ValueNotifier<bool>(false);
  ValueNotifier<int> currentQuestion = ValueNotifier<int>(0);
  String remianingTime;
  String timeTaken;
  // QuizDetailModel model;
  PageController _pageController;
  bool isQuizEnd = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    Provider.of<QuizState>(context, listen: false).getAssignmentDetail(widget.model.id);
  }

  @override
  dispose() {
    isDisplayQuestion.dispose();
    super.dispose();
  }

  Widget _headerSection(QuizState state) {
    final theme = Theme.of(context);
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16),
      color: PColors.red.withOpacity(.3),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              ValueListenableBuilder<int>(
                valueListenable: currentQuestion,
                builder: (BuildContext context, int value, Widget child) {
                  return Text(
                    "question: ${value + 1}/${state.quizModel.questions.length}",
                    style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
                  );
                },
              ),
              Spacer(),
              SizedBox(
                  height: 45,
                  width: 45,
                  child: Image.asset(Images.dropdown, height: 20).p16.ripple(() {
                    isDisplayQuestion.value = !isDisplayQuestion.value;
                  }))
            ],
          ),
          QuestionCountSection(isDisplayQuestion: isDisplayQuestion),
        ],
      ),
    );
  }

  Widget _question(Question model) {
    return Container(
      width: AppTheme.fullWidth(context),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(model.statement),
            SizedBox(height: 4),
            Column(
              children: model.options
                  .map((e) => Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: AppTheme.outline(context),
                        width: AppTheme.fullWidth(context) - 16,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Radio(
                            //   value: e,
                            //   groupValue: model.selectedAnswer,
                            //   onChanged: (val) {
                            //     print(val);
                            //   },
                            // ),
                            Icon(e == model.selectedAnswer ? Icons.check_circle_rounded : Icons.panorama_fish_eye,
                                    color: e == model.selectedAnswer ? PColors.green : PColors.gray)
                                .p16,
                            Text("sdc sd jsdn sjdn jskdnf kjs fjskdf sjdfn jsdf sjdf sjdb sjkdb fsjdb sjdb sk").extended,
                          ],
                        ),
                      ).ripple(() {
                        model.selectedAnswer = e;
                        Provider.of<QuizState>(context, listen: false).addAnswer(model);
                      }))
                  .toList(),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _body(QuizState state) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemCount: state.quizModel.questions.length,
      onPageChanged: (page) {
        currentQuestion.value = page;
      },
      itemBuilder: (context, index) {
        return _question(state.quizModel.questions[index]);
      },
    ).extended;
  }

  Widget _footer() {
    final theme = Theme.of(context);
    return Container(
      decoration: AppTheme.decoration(context),
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        buttonHeight: 45,
        // layoutBehavior: ButtonBarLayoutBehavior.constrained,
        children: [
          Container(
            decoration: AppTheme.outlinePrimary(context),
            width: AppTheme.fullWidth(context) * .45,
            child: FlatButton(
              onPressed: () {
                _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
              },
              child: Text(
                "Previous",
                style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
              ),
            ),
          ),
          Container(
            decoration: AppTheme.outlinePrimary(context),
            width: AppTheme.fullWidth(context) * .45,
            child: FlatButton(
              onPressed: () {
                _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
              },
              child: Text(
                "Next",
                style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget noQuiz() {
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

  void onTimerComplete(String timerText,{bool force = false}) {
    bool isTimerEnd = timerText == "0:00 time left";
    if (isQuizEnd) {
      print("Return from end");
      return;
    }else if(!force && isTimerEnd){
      isQuizEnd = true;
    }
    final state = Provider.of<QuizState>(context, listen: false);
    final unAnswered = state.quizModel.questions.where((element) => element.selectedAnswer == null).length;
    print("Quiz time End");
    
    Alert.dialog(
      context,
      title: "Review",
      buttonText: "Submit Quiz",
      titleBackGround: Color(0xffF7506A),
      onPressed: () {
        Navigator.pop(context);
        final state = Provider.of<QuizState>(context, listen: false);
        Navigator.pushReplacement(context, QuizRasultPage.getRoute(model: state.quizModel, batchId: state.batchId,timeTaken:timeTaken));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.timer, height: 20),
                SizedBox(width: 10),
                Text(timerText,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "$unAnswered  Unanswered questions",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 12),
            Wrap(
              children: Iterable.generate(state.quizModel.questions.skipWhile((value) => value.selectedAnswer != null).length, (index) {
                return _circularNo(
                    context, index, state.quizModel.questions.skipWhile((value) => value.selectedAnswer != null).toList()[index]);
              }).toList(),
            ),
            SizedBox(height: 42),
            Container(
              decoration: isTimerEnd ? AppTheme.outline(context) : AppTheme.outlinePrimary(context),
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: FlatButton(
                onPressed: isTimerEnd
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                // disabledColor: PColors.gray,
                child: Text(
                  "Go back to quiz",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.bold, color: isTimerEnd ? PColors.gray : Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _circularNo(context, int index, Question model) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: model.selectedAnswer != null ? PColors.green : Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        "${index + 1}",
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: model.selectedAnswer != null ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(Images.timer, height: 20),
            SizedBox(width: 10),
            Consumer<QuizState>(builder: (context, state, child) {
              if (state.quizModel != null && state.quizModel.duration != null)
                return Timer(
                  duration: state.quizModel.duration,
                  onTimerComplete: onTimerComplete,
                  onTimerChanged: (value) {
                    remianingTime = value;
                  },
                  timeTaken:(val){
                    timeTaken = val;
                  }
                );
              return Text("", style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold));
            }),
          ],
        ),
        actions: [
          Center(
            child: Text("Submit", style: theme.textTheme.button.copyWith(color: theme.primaryColor)).p16.ripple(() {
              onTimerComplete(remianingTime,force:true);
            }),
          )
        ],
      ),
      body: Consumer<QuizState>(
        builder: (context, state, child) {
          if (state.isBusy) {
            return Ploader();
          }
          if (!(state.quizModel != null && state.quizModel.questions != null)) {
            return noQuiz();
          }
          return Container(
            height: AppTheme.fullHeight(context),
            child: Column(
              children: <Widget>[
                _headerSection(state),
                _body(state),
                _footer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
