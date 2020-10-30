import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/quiz_model.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class QuizSolutionPage extends StatelessWidget {
  const QuizSolutionPage({Key key, this.model}) : super(key: key);
  final QuizDetailModel model;

  static MaterialPageRoute getRoute(QuizDetailModel model) {
    return MaterialPageRoute(
        builder: (_) => QuizSolutionPage(
              model: model,
            ));
  }

  Widget _questionTile(BuildContext context, Question model) {
    final correct = model.selectedAnswer == model.answer;
    return Container(
      // padding: EdgeInsets.symmetric( vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: correct ? AppTheme.outlineSucess(context) : AppTheme.outlineError(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 16),
          Container(
            width:AppTheme.fullWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            color: correct?  PColors.green.withOpacity(.3) : PColors.red.withOpacity(.3),
            child:Text(model.statement, style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 12),
          
          Text("Your Answer", style: Theme.of(context).textTheme.subtitle2).hP16,
          Text(model.answer, style: Theme.of(context).textTheme.subtitle1).hP16,
          if (!correct) ...[
            SizedBox(height: 8),
            Divider(height:12, color:PColors.red.withOpacity(.3),thickness: 1,),
            SizedBox(height: 8),
            Text("Correct Answer", style: Theme.of(context).textTheme.subtitle2).hP16,
            Text(model.selectedAnswer, style: Theme.of(context).textTheme.subtitle1).hP16,
          ],
          SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: PColors.pink,
        iconTheme: IconThemeData(color: PColors.white),
        title: Text("Solution", style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount:  model.questions.length,
                itemBuilder: (context, index) {
                  int i = 2 % (index + 1) == 2 ? 0 : 1;
                  return _questionTile(context, model.questions[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
