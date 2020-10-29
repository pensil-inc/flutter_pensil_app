import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/states/quiz/quiz_state.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class QuestionCountSection extends StatelessWidget {
  const QuestionCountSection({Key key, this.isDisplayQuestion}) : super(key: key);
  final ValueNotifier<bool> isDisplayQuestion;
  Widget _circularNo(context, int index, Question model) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: model.selectedAnswer != null ? PColors.green : Colors.white,
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
    return ValueListenableBuilder<bool>(
      valueListenable: isDisplayQuestion,
      builder: (BuildContext context, bool value, Widget child) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.decelerate,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: !value ? 0 : 16),
          width: AppTheme.fullWidth(context),
          decoration: AppTheme.decoration(context).copyWith(
            color: PColors.red.withOpacity(.1),
          ),
          child: !value
              ? SizedBox.shrink()
              : Consumer<QuizState>(
                  builder: (context, state, child) {
                    return Wrap(
                      children: Iterable.generate(state.quizModel.questions.length, (index) {
                        return _circularNo(context, index, state.quizModel.questions[index]);
                      }).toList(),
                    );
                  },
                ),
        );
      },
    );
  }
}
