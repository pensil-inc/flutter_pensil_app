import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/ui/page/home/widget/poll_widget.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/secondary_app_bar.dart';
import 'package:provider/provider.dart';

class ViewAllPollPage extends StatelessWidget {
  const ViewAllPollPage({Key key}) : super(key: key);
  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (_) => ViewAllPollPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("All Polls"),
      body: Consumer<HomeState>(
        builder: (context, state, child) {
          if (state.allPolls == null) {
            return Center(
              child: Container(
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 32),
                decoration: AppTheme.outline(context),
                width: AppTheme.fullWidth(context),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("No Polls available",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: PColors.gray,
                            )),
                    SizedBox(height: 10),
                    Text("Polls are not created yet.",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
            );
          }
          return Container(
            child: ListView.builder(
              itemCount: state.allPolls.length,
              itemBuilder: (context, index) {
                return PollWidget(model: state.allPolls[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
