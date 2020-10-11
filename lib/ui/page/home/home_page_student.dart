import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/ui/page/announcement/create_announcement.dart';
import 'package:flutter_pensil_app/ui/page/auth/login.dart';
import 'package:flutter_pensil_app/ui/page/create_batch/create_batch.dart';
import 'package:flutter_pensil_app/ui/page/home/student_list_preview.dart';
import 'package:flutter_pensil_app/ui/page/home/widget/poll_widget.dart';
import 'package:flutter_pensil_app/ui/page/notification/notifications_page.dart';
import 'package:flutter_pensil_app/ui/page/poll/create_poll.dart';
import 'package:flutter_pensil_app/ui/theme/light_color.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key key}) : super(key: key);
  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(builder: (_) => StudentHomePage());
  }

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;
  Animation<double> _translateButton;
  bool showFabButton = false;

  @override
  void initState() {
    super.initState();
    setupAnimations();
    Provider.of<HomeState>(context, listen: false).getBatchList();
    Provider.of<HomeState>(context, listen: false).getAnnouncemantList();
    Provider.of<HomeState>(context, listen: false).getPollList();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
    showFabButton = !showFabButton;
  }

  setupAnimations() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _controller.repeat();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _translateButton = Tween<double>(
      begin: 100,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        1,
        curve: _curve,
      ),
    ));
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  Widget _floatingActionButtonColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // _smallFabButton(
        //   Images.people,
        //   text: 'Create Batch',
        //   animationValue: 2,
        //   onPressed: () {
        //     animate();
        //      Navigator.push(context, CreateBatch.getRoute());
        //   },
        // ),
        _smallFabButton(
          Images.announcements,
          text: 'Notifications',
          animationValue: 1,
          onPressed: () {
            animate();
            Navigator.push(context, NotificationPage.getRoute());
          },
        ),
      ],
    );
  }

  Widget _smallFabButton(String icon,
      {Function onPressed, double animationValue, String text = ''}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Transform(
        transform: Matrix4.translationValues(
          _translateButton.value * animationValue,
          0.0,
          0.0,
        ),
        child: Material(
          elevation: 4,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(40)),
          ),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(40)),
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(icon, height: 20),
                  SizedBox(width: 8),
                  Text(text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary)),
                ],
              )).ripple(
            onPressed,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(40),
            ),
          ),
        ),
      ),
    );
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
      floatingActionButton: _floatingActionButton(),
      appBar: AppBar(
        title: Title(color: PColors.black, child: Text("Student Home page")),
        actions:<Widget>[
          Center(
            child: SizedBox(
              height:40,
              child: OutlineButton(
                onPressed: (){
                  Navigator.pushReplacement(context, LoginPage.getRoute());
                },
                child:Text("Sign out")
              ),
            ),
          ).hP16,
        ]
      ),
      body: Stack(
        children: <Widget>[
          Consumer<HomeState>(
            builder: (context, state, child) {
              if (state.batchList == null) return Ploader();
              return CustomScrollView(
                slivers: <Widget>[
                  if (!(state.batchList != null && state.batchList.isNotEmpty))
                   SliverList(
                    delegate: SliverChildListDelegate([
                      _title("My Batches"),
                      SizedBox(height:20),
                      Container(
                        height:100,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration:AppTheme.outline(context),
                        width: AppTheme.fullWidth(context),
                        alignment: Alignment.center,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Text("You have no batch",style:Theme.of(context).textTheme.headline6.copyWith(color:PColors.gray, )),
                          SizedBox(height:10),
                          Text("Ask your teacher to add you in a batch!!",style:Theme.of(context).textTheme.bodyText1),
                        ],)
                      )
                    ],),),
                  if (state.batchList != null && state.batchList.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == 0)
                          return _title("My Batches");
                        return _batch(state.batchList[index - 1]);
                      },
                      childCount: state.batchList.length + 1,
                    ),
                  ),
                  if (state.polls != null && state.polls.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == 0)
                            return  _title("Today's Poll");

                          return PollWidget(model: state.polls[index - 1]);
                        },
                        childCount: state.polls.length + 1,
                      ),
                    ),
                  if (state.announcementList != null && state.announcementList.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == 0)
                            return _title(
                                "Announcement");
                          return _announcement(
                              state.announcementList[index - 1]);
                        },
                        childCount: state.batchList.length + 1,
                      ),
                    ),
                ],
              );
            },
          ),
          AnimatedPositioned(
            bottom: 16 + 60.0,
            right: 25, //showFabButton ? 25 : 0,
            duration: Duration(milliseconds: 500),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: showFabButton ? 1 : 0,
              child: _floatingActionButtonColumn(),
            ),
          )
        ],
      ),
    );
  }
}
