import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/states/teacher/batch_detail_state.dart';
import 'package:flutter_pensil_app/states/teacher/material/batch_material_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/kit/overlay_loader.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/material/upload_material.dart';
import 'package:flutter_pensil_app/ui/page/batch/widget/tile_action_widget.dart';
import 'package:flutter_pensil_app/ui/page/common/pdf_view.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:provider/provider.dart';

class BatchMaterialCard extends StatelessWidget {
  const BatchMaterialCard(
      {Key key,
      this.loader,
      this.model,
      this.actions = const ["Edit", "Delete"]})
      : super(key: key);
  final CustomLoader loader;
  final List<String> actions;
  final BatchMaterialModel model;

  Widget _picture(context, String type) {
    if (type == null && model.articleUrl != null) {
      type = "link";
    }
    // return empty widget if space has no pictures
    return // Picture
        Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppTheme.decoration(context),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        child: Stack(
          // fit: StackFit.expand,
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              width: 5,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: PColors.blue, width: 6)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                width: 50,
                child: type == null
                    ? SizedBox()
                    : Image.asset(
                        Images.getfiletypeIcon(type),
                        fit: BoxFit.fitHeight,
                        width: 50,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openMaterial(context, BatchMaterialModel model) {
    if (model.file != null || model.articleUrl != null) {
      if (model.articleUrl != null) {
        // Utility.launchURL(context, model.articleUrl ?? model.file);
        Utility.launchOnWeb(model.articleUrl ?? model.file);
      } else if (model.file.contains("pdf")) {
        Navigator.push(
            context, PdfViewPage.getRoute(model.file, title: model.title));
      } else {
        Utility.launchOnWeb(model.file);
      }
    }
  }

  void deleteVideo(BuildContext context, String id) async {
    Alert.yesOrNo(context,
        message: "Are you sure, you want to delete this material ?",
        title: "Message",
        barrierDismissible: true,
        onCancel: () {}, onYes: () async {
      loader.showLoader(context);
      final isDeleted =
          await context.read<BatchMaterialState>().deleteMaterial(id);
      await context.read<BatchDetailState>().getBatchTimeLine();
      if (isDeleted) {
        Utility.displaySnackbar(context, msg: "Material Deleted");
      }
      loader.hideLoader();
    });
  }

  void editMaterial(context, BatchMaterialModel model) {
    Navigator.push(
      context,
      UploadMaterialPage.getEditRoute(
        model,
        state: Provider.of<BatchMaterialState>(context, listen: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                onTap: () => openMaterial(context, model),
                child: _picture(context, model.fileType),
              )),
          Expanded(
            child: InkWell(
              onTap: () => openMaterial(context, model),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model.title,
                          style: Theme.of(context).textTheme.subtitle2,
                          maxLines: 3,
                        ),
                        // Text(model.description,style: Theme.of(context).textTheme.bodyText2,maxLines: 2, ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            PChip(
                              backgroundColor: PColors.orange,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                              borderColor: Colors.transparent,
                              label: model.subject ?? "N/A",
                            ),
                            Text(
                              Utility.toDMformate(model.createdAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Theme.of(context).disabledColor),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (Provider.of<HomeState>(context).isTeacher)
            TileActionWidget(
              list: actions,
              onDelete: () => deleteVideo(context, model.id),
              onEdit: () => editMaterial(context, model),
            ),
        ],
      ),
    );
  }
}
