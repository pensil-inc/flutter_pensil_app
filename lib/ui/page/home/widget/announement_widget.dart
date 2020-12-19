import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/kit/overlay_loader.dart';
import 'package:flutter_pensil_app/ui/page/batch/widget/tile_action_widget.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/image_viewer.dart';
import 'package:flutter_pensil_app/ui/widget/url_Text.dart';
import 'package:provider/provider.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget(this.model,
      {Key key,
      this.isTeacher = false,
      this.loader,
      this.onAnnouncementDeleted})
      : super(key: key);
  final AnnouncementModel model;
  final bool isTeacher;
  final CustomLoader loader;
  final Function(AnnouncementModel) onAnnouncementDeleted;

  void deleteAnnouncement(BuildContext context, String id) async {
    Alert.yesOrNo(context,
        message: "Are you sure, you want to delete this annoucement ?",
        title: "Message",
        barrierDismissible: true,
        onCancel: () {}, onYes: () async {
      loader.showLoader(context);
      final isDeleted = await Provider.of<HomeState>(context, listen: false)
          .deleteAnnouncement(id);
      if (isDeleted) {
        Utility.displaySnackbar(context, msg: "Annoucement Deleted");
        if (onAnnouncementDeleted != null) onAnnouncementDeleted(model);
      }
      loader.hideLoader();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: AppTheme.decoration(context)
          .copyWith(color: Theme.of(context).primaryColor),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Container(
                    child: Image.asset(
                      Images.megaphone,
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.onPrimary,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16) +
                              EdgeInsets.only(right: isTeacher ? 10 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          UrlText(text: model.description),
                          SizedBox(height: 8),
                          if (model.image != null &&
                              model.image.isNotEmpty) ...[
                            CachedNetworkImage(
                                    imageUrl: model.image, height: 120)
                                .ripple(() {
                              Navigator.push(
                                  context, ImageViewer.getRoute(model.image));
                            }),
                            SizedBox(height: 8),
                          ],
                          if (model.file != null)
                            RotatedBox(
                              quarterTurns: 1,
                              child:
                                  Icon(Icons.attach_file_outlined).ripple(() {
                                Utility.launchOnWeb(model.file);
                              }),
                            ).alignCenterRight,
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (model.owner != null &&
                                    model.owner.name != null)
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "by ${model.owner.name} ~ ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                Text(
                                  Utility.toTimeOfDate(model.createdAt),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).extended,
                  ],
                ),
              ),
            ],
          ),
          if (isTeacher)
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 20,
                alignment: Alignment.topRight,
                color: Theme.of(context).colorScheme.onPrimary,
                child: TileActionWidget(
                  onDelete: () => deleteAnnouncement(context, model.id),
                  list: ["Delete"],
                ),
              ),
            )
        ],
      ),
    );
  }
}
