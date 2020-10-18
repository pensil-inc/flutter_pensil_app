import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/states/teacher/announcement_state.dart';
import 'package:flutter_pensil_app/states/teacher/material/batch_material_state.dart';
import 'package:flutter_pensil_app/states/teacher/video/video_state.dart';
import 'package:flutter_pensil_app/ui/page/announcement/create_announcement.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/batch_assignment_page.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/batch_study_material_page.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/detail/batch_detail_page.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/material/upload_material.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/add_video_page.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/batch_videos_page.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/fab/animated_fab.dart';
import 'package:flutter_pensil_app/ui/widget/fab/fab_button.dart';
import 'package:provider/provider.dart';

class BatchMasterDetailPage extends StatefulWidget {
  BatchMasterDetailPage({Key key, this.model}) : super(key: key);
  final BatchModel model;
  static MaterialPageRoute getRoute(BatchModel model) {
    return MaterialPageRoute(
      builder: (_) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => VideoState(batchId: model.id)),
          ChangeNotifierProvider(create: (_) => BatchMaterialState(batchId: model.id)),
          ChangeNotifierProvider(create: (_) => AnnouncementState(batchId: model.id)),
        ],
        builder: (_, child) => BatchMasterDetailPage(model: model),
      ),
    );
  }

  @override
  _BatchMasterDetailPageState createState() => _BatchMasterDetailPageState();
}

class _BatchMasterDetailPageState extends State<BatchMasterDetailPage> with TickerProviderStateMixin {
  BatchModel model;
  AnimationController _controller;
  TabController _tabController;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;
  Animation<double> _translateButton;
  ValueNotifier<bool> showFabButton = ValueNotifier<bool>(false);
  ValueNotifier<int> currentPageNo = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    model = widget.model;
    setupAnimations();
    _tabController = TabController(length: 4, vsync: this)..addListener(tabListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<VideoState>(context, listen: false).getVideosList();
      Provider.of<BatchMaterialState>(context, listen: false).getBatchMaterialList();
      Provider.of<AnnouncementState>(context, listen: false).getBatchAnnouncementList();
    });
    super.initState();
  }

  tabListener() {
    currentPageNo.value = _tabController.index;
  }

  @override
  void dispose() {
    // showFabButton.dispose();
    // _animationController.dispose();
    // _tabController.dispose();
    super.dispose();
  }

  setupAnimations() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    _controller.repeat();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
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

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
    showFabButton.value = !showFabButton.value;
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

  List<Widget> _floatingButtons(int index) {
    return <Widget>[
      if (index != 5) ...[
        FabButton(
          icon: Images.edit,
          text: 'Add  Video',
          translateButton: _translateButton,
          animationValue: 3,
          onPressed: () {
            animate();
            Navigator.push(
              context,
              AddVideoPage.getRoute(
                subject: model.subject,
                batchId: model.id,
                state: Provider.of<VideoState>(context, listen: false),
              ),
            );
          },
        ),
        FabButton(
          icon: Images.upload,
          text: 'Upload Material',
          animationValue: 2,
          translateButton: _translateButton,
          onPressed: () {
            animate();
            Navigator.push(
                context,
                UploadMaterialPage.getRoute(
                  model.subject,
                  model.id,
                  state: Provider.of<BatchMaterialState>(context, listen: false),
                ));
          },
        ),
        FabButton(
          icon: Images.announcements,
          text: 'Add Announcement',
          translateButton: _translateButton,
          
          animationValue: 1,
          onPressed: () {
            animate();
            final model = widget.model;
            model.isSelected = true;
            Navigator.push(context, CreateAnnouncement.getRoute(
              selectedBatch: model,
              onAnnouncementCreated:onAnnouncementCreated,
            ));
          },
        ),
      ],
    ];
  }
 
  void onAnnouncementCreated()async{
    Provider.of<AnnouncementState>(context, listen: false).getBatchAnnouncementList();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: _floatingActionButton(),
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Theme.of(context).textTheme.bodyText1.color,
            tabs: [
              Tab(text: "Detail"),
              Tab(text: "Assignment"),
              Tab(text: "Videos"),
              Tab(text: "Study Material"),
            ],
          ),
          title: Title(
            color: PColors.black,
            child: Text(model.name),
          ),
        ),
        body: Stack(
          children: <Widget>[
            TabBarView(
              controller: _tabController,
              children: [BatchDetailPage(model: model), BatchAssignmentPage(), BatchVideosPage(), BatchStudyMaterialPage()],
            ),
            ValueListenableBuilder(
              valueListenable: currentPageNo,
              builder: (BuildContext context, dynamic index, Widget child) {
                return AnimatedFabButton(showFabButton: showFabButton, children: _floatingButtons(index));
              },
            ),
          ],
        ),
      ),
    );
  }
}
