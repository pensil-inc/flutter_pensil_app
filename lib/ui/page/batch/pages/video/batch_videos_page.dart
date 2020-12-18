import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/model/choice.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/states/teacher/video/video_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/kit/overlay_loader.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/add_video_page.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/video_player_pag2e.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/video_player_page.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/widget/batch_video_Card.dart';
import 'package:flutter_pensil_app/ui/page/batch/widget/tile_action_widget.dart';
import 'package:flutter_pensil_app/ui/page/common/web_view.page.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:provider/provider.dart';

class BatchVideosPage extends StatefulWidget {
  const BatchVideosPage({Key key, this.model, this.loader}) : super(key: key);
  final BatchModel model;
  final CustomLoader loader;
  static MaterialPageRoute getRoute(BatchModel model, CustomLoader loader) {
    return MaterialPageRoute(
        builder: (_) => BatchVideosPage(model: model, loader: loader));
  }

  @override
  _BatchVideosPageState createState() => _BatchVideosPageState();
}

class _BatchVideosPageState extends State<BatchVideosPage> {
  @override
  void initState() {
    super.initState();
  }

  // Widget _videoCard(VideoModel model) {
  //   return Container(
  //       decoration: AppTheme.decoration(context),
  //       margin: EdgeInsets.only(bottom: 12),
  //       height: 100,
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           AspectRatio(
  //             aspectRatio: 1,
  //             child: _picture(model.thumbnailUrl),
  //           ),
  //           Expanded(
  //               child: InkWell(
  //             onTap: () {
  //               if (model.video != null) {
  //                 Navigator.push(
  //                     context,
  //                     VideoPlayerPage2.getRoute(model.video,
  //                         title: model.title));
  //               } else if (model.videoUrl != null) {
  //                 Navigator.push(context,
  //                     WebViewPage.getRoute(model.videoUrl, title: model.title));
  //               }
  //             },
  //             child: Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     model.title,
  //                     style: Theme.of(context).textTheme.subtitle2,
  //                     maxLines: 3,
  //                   ),
  //                   // Text(model.description,style: Theme.of(context).textTheme.bodyText2,maxLines: 2, ),
  //                   Spacer(),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[
  //                       PChip(
  //                         backgroundColor: PColors.randomColor(model.subject),
  //                         style: Theme.of(context).textTheme.bodyText2.copyWith(
  //                               color: Theme.of(context).colorScheme.onPrimary,
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                         borderColor: Colors.transparent,
  //                         label: model.subject ?? "N/A",
  //                       ),
  //                       Text(
  //                         Utility.toDMformate(model.createdAt),
  //                         style: Theme.of(context).textTheme.bodyText2.copyWith(
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 12,
  //                             color: Theme.of(context).disabledColor),
  //                       )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )),
  //           if (Provider.of<HomeState>(context).isTeacher)
  //             TileActionWidget(
  //               onDelete: () => deleteVideo(model.id),
  //               onEdit: () => editVideo(model),
  //             ),
  //         ],
  //       ));
  // }

  // Widget _picture(String url) {
  //   // return empty widget if space has no pictures
  //   if (url == null || !(url.contains("jpg") || url.contains("png"))) {
  //     return ClipRRect(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(5),
  //         bottomLeft: Radius.circular(5),
  //       ),
  //       child: Container(
  //         alignment: Alignment.center,
  //         color: Color(0xffeaeaea),
  //         child: url == null
  //             ? Container(
  //                 decoration: BoxDecoration(
  //                     image: DecorationImage(
  //                         image: AssetImage(Images.videoPlay),
  //                         fit: BoxFit.cover)),
  //               )
  //             : Container(
  //                 height: 40,
  //                 width: 40,
  //                 decoration: BoxDecoration(
  //                   border: Border.all(),
  //                   borderRadius: BorderRadius.circular(30),
  //                   color: Color(0xffffffff),
  //                 ),
  //                 child: Center(child: Icon(Icons.play_arrow)),
  //               ),
  //       ),
  //     );
  //   }

  //   return // Picture
  //       ClipRRect(
  //     borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
  //     child: Image.network(
  //       url != null ? url : "",
  //       fit: BoxFit.cover,
  //       loadingBuilder: (BuildContext context, Widget child,
  //           ImageChunkEvent loadingProgress) {
  //         if (loadingProgress == null) return child;
  //         return Center(
  //           child: CircularProgressIndicator(
  //             value: loadingProgress.expectedTotalBytes != null
  //                 ? loadingProgress.cumulativeBytesLoaded /
  //                     loadingProgress.expectedTotalBytes
  //                 : null,
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // void deleteVideo(String id) async {
  //   Alert.yesOrNo(context,
  //       message: "Are you sure, you want to delete this video ?",
  //       title: "Message",
  //       barrierDismissible: true,
  //       onCancel: () {}, onYes: () async {
  //     widget.loader.showLoader(context);
  //     final isDeleted =
  //         await Provider.of<VideoState>(context, listen: false).deleteVideo(id);
  //     if (isDeleted) {
  //       Utility.displaySnackbar(context, msg: "Video Deleted");
  //     }
  //     widget.loader.hideLoader();
  //   });
  // }

  // void editVideo(VideoModel model) {
  //   Navigator.push(
  //     context,
  //     AddVideoPage.getEditRoute(
  //       model,
  //       state: Provider.of<VideoState>(context, listen: false),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<VideoState>(
        builder: (context, state, child) {
          if (state.isBusy) {
            return Ploader();
          }
          if (state.list.isEmpty) {
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
                  Text("No video is uploaded yet for this batch!!",
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center),
                ],
              ),
            );
          }
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemCount: state.list.length,
              itemBuilder: (_, index) {
                return BatchVideoCard(
                    model: state.list[index], loader: widget.loader);
              });
        },
      ),
    );
  }
}
