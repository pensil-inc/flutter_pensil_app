import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/batch_time_slot_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/states/teacher/announcement_state.dart';
import 'package:flutter_pensil_app/states/teacher/batch_detail_state.dart';
import 'package:flutter_pensil_app/ui/kit/overlay_loader.dart';
import 'package:flutter_pensil_app/ui/page/announcement/create_announcement.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/detail/student_list.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/material/widget/batch_material_card.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/widget/batch_video_Card.dart';
import 'package:flutter_pensil_app/ui/page/home/widget/announcement_widget.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_avatar.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class BatchDetailPage extends StatelessWidget {
  const BatchDetailPage({Key key, this.batchModel, this.loader})
      : super(key: key);
  final BatchModel batchModel;
  final CustomLoader loader;
  static MaterialPageRoute getRoute(BatchModel model) {
    return MaterialPageRoute(
        builder: (_) => BatchDetailPage(batchModel: model));
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
            children: batchModel.studentModel
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
    context.read<AnnouncementState>().onAnnouncementDeleted(model);
    context.read<BatchDetailState>().getBatchTimeLine();
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
                  _title(context, batchModel.name).vP8,
                  Wrap(
                    children: <Widget>[
                      PChip(
                        style: theme.textTheme.bodyText1
                            .copyWith(color: theme.colorScheme.onPrimary),
                        borderColor: Colors.transparent,
                        label: batchModel.subject,
                        backgroundColor:
                            PColors.randomColor(batchModel.subject),
                      ),
                    ],
                  ),
                  SizedBox(height: 19),
                  Row(
                    children: <Widget>[
                      Image.asset(Images.calender, width: 20),
                      SizedBox(width: 10),
                      _title(context, "${batchModel.classes.length} Classes",
                          fontSize: 18),
                    ],
                  )
                ],
              ).hP16,
              SizedBox(height: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: batchModel.classes
                    .map((e) => _timing(context, e).vP4)
                    .toList(),
              ).hP16,
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(Images.peopleBlack, width: 20),
                  SizedBox(width: 10),
                  _title(context, "${batchModel.studentModel.length} Student",
                      fontSize: 18),
                  Spacer(),
                  SizedBox(
                    height: 30,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            StudentListPage.getRoute(batchModel.studentModel));
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
        SliverToBoxAdapter(child: Divider(height: 1, thickness: 1)),
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
                      loader: loader,
                      onAnnouncementDeleted: (model) {
                        onAnnouncementDeleted(context, model);
                      },
                      onAnnouncementEdit: (model) {
                        Navigator.push(
                          context,
                          CreateAnnouncement.getEditRoute(
                            batch: batchModel,
                            announcementModel: model,
                            onAnnouncementCreated: () {
                              print(
                                  "-------------------------------------------");
                              // if an announcement is created or edited then
                              // refresh timelime api
                              context
                                  .read<BatchDetailState>()
                                  .getBatchTimeLine();
                            },
                          ),
                        );
                      },
                    );
                  },
                  childCount: state.batchAnnouncementList.length + 1,
                ),
              );

            return SliverToBoxAdapter();
          },
        ),
        // SliverToBoxAdapter(child: Divider()),
        // Batch video, announcement, study material timeline
        Consumer<BatchDetailState>(builder: (context, state, child) {
          if (state.timeLineList != null && state.timeLineList.isNotEmpty) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index == 0)
                  return _title(context, "Batch Timeline", fontSize: 18).p16;
                final model = state.timeLineList[index - 1];
                if (model.datum is VideoModel) {
                  return BatchVideoCard(model: model.datum, loader: loader)
                      .hP16
                      .vP4;
                }
                if (model.datum is AnnouncementModel) {
                  return AnnouncementWidget(
                    model.datum,
                    actions: ["Delete"],
                    loader: loader,
                    onAnnouncementDeleted: (model) {
                      onAnnouncementDeleted(context, model);
                    },
                  ).vP4;
                }
                if (model.datum is BatchMaterialModel) {
                  return BatchMaterialCard(model: model.datum, loader: loader)
                      .hP16
                      .vP4;
                }
                print(
                    "Unknown item found on batch timeline\n Type: ${model.type}");
                return SizedBox();
              }, childCount: state.timeLineList.length + 1),
            );
          }
          return SliverToBoxAdapter();
        }),
        SliverToBoxAdapter(child: SizedBox(height: 70))
      ],
    );
  }
}
