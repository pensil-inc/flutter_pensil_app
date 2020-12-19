import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/batch_time_slot_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/states/teacher/announcement_state.dart';
import 'package:flutter_pensil_app/states/teacher/batch_detail_state.dart';
import 'package:flutter_pensil_app/ui/kit/overlay_loader.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/detail/student_list.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/material/widget/batch_material_card.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/widget/batch_video_Card.dart';
import 'package:flutter_pensil_app/ui/page/home/widget/announement_widget.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_avatar.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class BatchDetailPage extends StatelessWidget {
  const BatchDetailPage({Key key, this.model, this.loader}) : super(key: key);
  final BatchModel model;
  final CustomLoader loader;
  static MaterialPageRoute getRoute(BatchModel model) {
    return MaterialPageRoute(builder: (_) => BatchDetailPage(model: model));
  }

  Widget _title(context, String text, {double fontSize = 22}) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline6
          .copyWith(fontSize: fontSize, fontWeight: FontWeight.w500),
    );
  }

  Widget _timing(context, BatchTimeSlotModel model) {
    return Text(
      "${model.toshortDay()}  ${Utility.timeFrom24(model.startTime)} - ${Utility.timeFrom24(model.endTime)}",
      style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
    );
  }

  Widget _students(ThemeData theme) {
    return Wrap(
            children: model.studentModel
                .map((model) => SizedBox(
                      height: 35,
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: UsernameWidget(
                          name: model.name,
                          textStyle: theme.textTheme.bodyText1.copyWith(
                              fontSize: 12, color: theme.colorScheme.onPrimary),
                          backGroundColor: PColors.randomColor(model.name),
                        ),
                      ),
                    ))
                .toList())
        .p16;
  }

  void onAnnouncementDeleted(BuildContext context, AnnouncementModel model) {
    Provider.of<AnnouncementState>(context, listen: false)
        .onAnnouncementDeleted(model);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _title(context, model.name).vP8,
                  Wrap(
                    children: <Widget>[
                      PChip(
                        style: theme.textTheme.bodyText1
                            .copyWith(color: theme.colorScheme.onPrimary),
                        borderColor: Colors.transparent,
                        label: model.subject,
                        backgroundColor: PColors.randomColor(model.subject),
                      ),
                    ],
                  ),
                  SizedBox(height: 19),
                  Row(
                    children: <Widget>[
                      Image.asset(Images.calender, width: 20),
                      SizedBox(width: 10),
                      _title(context, "${model.classes.length} Classes",
                          fontSize: 18),
                    ],
                  )
                ],
              ).hP16,
              SizedBox(height: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    model.classes.map((e) => _timing(context, e).vP4).toList(),
              ).hP16,
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(Images.peopleBlack, width: 20),
                  SizedBox(width: 10),
                  _title(context, "${model.studentModel.length} Student",
                      fontSize: 18),
                  Spacer(),
                  SizedBox(
                    height: 30,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            StudentListPage.getRoute(model.studentModel));
                      },
                      child: Text("View All"),
                    ),
                  )
                ],
              ).hP16,
              _students(theme),
            ],
          ),
        ),
        SliverToBoxAdapter(child: Divider(height: 1, thickness: 1).pB(8)),
        Consumer<AnnouncementState>(
          builder: (context, state, child) {
            if (state.isBusy) {
              return SliverToBoxAdapter(child: PCLoader(stroke: 2));
            }
            if (state.batchAnnouncementList != null &&
                state.batchAnnouncementList.isNotEmpty)
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0)
                      return _title(context, "Recent Announcement",
                              fontSize: 18)
                          .p16;
                    return AnnouncementWidget(
                        state.batchAnnouncementList[index - 1],
                        isTeacher: Provider.of<HomeState>(context).isTeacher,
                        loader: loader,
                        onAnnouncementDeleted: (model) =>
                            onAnnouncementDeleted(context, model));
                  },
                  childCount: state.batchAnnouncementList.length + 1,
                ),
              );

            return SliverToBoxAdapter();
          },
        ),
        // Batch video, announcement, study material timeline
        Consumer<BatchDetailState>(builder: (context, state, child) {
          if (state.timeLineList != null) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final model = state.timeLineList[index];
                if (model.datum is VideoModel) {
                  return BatchVideoCard(model: model.datum, loader: loader)
                      .hP16
                      .vP4;
                }
                if (model.datum is AnnouncementModel) {
                  return AnnouncementWidget(model.datum).vP4;
                }
                if (model.datum is BatchMaterialModel) {
                  return BatchMaterialCard(model: model.datum, loader: loader)
                      .hP16
                      .vP4;
                }
                print(
                    "Unknown item found on batch timeline\n Type: ${model.type}");
                return SizedBox();
              }, childCount: state.timeLineList.length),
            );
          }
          return SliverToBoxAdapter();
        }),
        SliverToBoxAdapter(child: SizedBox(height: 70))
      ],
    );
  }
}
