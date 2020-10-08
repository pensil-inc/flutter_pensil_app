import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/ui/page/create_batch.dart';
import 'package:flutter_pensil_app/ui/page/home/student_list_preview.dart';
import 'package:flutter_pensil_app/ui/page/home/widget/poll_widget.dart';
import 'package:flutter_pensil_app/ui/page/poll/create_poll.dart';
import 'package:flutter_pensil_app/ui/theme/light_color.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeState>(context, listen: false).getBatchList();
  }

  Widget _batch(BatchModel model) {
    final theme = Theme.of(context);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: AppTheme.decoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(model.name,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            PChip(
              label: model.subject,
              backgroundColor: Color(0xffF67619),
              borderColor: Colors.transparent,
              style: theme.textTheme.bodyText1
                  .copyWith(fontSize: 14, color: theme.colorScheme.onSecondary),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Row(
                    // children: model.classes.map((e) => Text(e.toshortDay()).hP4).toList()
                    children: Iterable.generate(model.classes.length, (index) {
                  final e = model.classes[index];
                  return Text(e.toshortDay() +
                          (model.classes.length == index + 1 ? "" : ","))
                      .hP4;
                }).toList()),
                Spacer(),
                StudentListPreview(list: model.studentModel),
              ],
            )
          ],
        ));
  }

  Widget _announcement(AnnouncementModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: AppTheme.decoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.description),
          // Wrap(
          //   children:model.batches.map((e) => PChip(
          //     label:e
          //   )).toList()
          // ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
                Utility.getPassedTime(model.createdAt.toIso8601String()),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
      ),
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontSize: 28, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: PColors.black, child: Text("Home page")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, CreatePoll.getRoute());
          // Provider.of<HomeState>(context, listen: false).getAnnouncemantList();
          Provider.of<HomeState>(context, listen: false).getPollList();
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
      body: Consumer<HomeState>(
        builder: (context, state, child) {
          if (state.batchList == null) return Ploader();
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0)
                      return _title("${state.batchList.length} Batches");
                    return _batch(state.batchList[index - 1]);
                  },
                  childCount: state.batchList.length + 1,
                ),
              ),
              if (state.polls != null)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0)
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _title("Today's Poll"),
                            OutlineButton(
                              onPressed: () {
                                Navigator.push(context, CreateBatch.getRoute());
                              },
                              textColor: Theme.of(context).primaryColor,
                              highlightedBorderColor:
                                  Theme.of(context).primaryColor,
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text("Create Poll"),
                            ).hP16
                          ],
                        );

                      return PollWidget(model: state.polls[index - 1]);
                    },
                    childCount: state.polls.length + 1,
                  ),
                ),
              if (state.announcementList != null)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0)
                        return _title(
                            "${state.announcementList.length} Announcement");
                      return _announcement(state.announcementList[index - 1]);
                    },
                    childCount: state.batchList.length + 1,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
