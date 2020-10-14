import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/states/teacher/material/batch_material_state.dart';
import 'package:flutter_pensil_app/ui/page/common/web_view.page.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:provider/provider.dart';

class BatchStudyMaterialPage extends StatelessWidget {
  const BatchStudyMaterialPage({Key key, this.model}) : super(key: key);
  final BatchModel model;
  static MaterialPageRoute getRoute(BatchModel model) {
    return MaterialPageRoute(
        builder: (_) => BatchStudyMaterialPage(
              model: model,
            ));
  }

  Widget _materialCard(context, BatchMaterialModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: _picture(context, model.fileType),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                        PChip(
                          backgroundColor: PColors.orange,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                          borderColor: Colors.transparent,
                          label: model.subject ?? "N/A",
                        ),
                        Text(Utility.toDMformate(model.createdAt),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Theme.of(context).disabledColor))
                      ])
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ).ripple(() {
        if(model.file != null)
        Utility.launchOnWeb(model.file);
        // Navigator.push(context, WebViewPage.getRoute(model.file));
      }),
    );
  }

  Widget _picture(context, String type) {
    // return empty widget if space has no pictures
    return // Picture
        Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppTheme.decoration(context),
      alignment: Alignment.center,
      child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
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
                  child: Image.asset(
                    Images.getfiletypeIcon(type),
                    fit: BoxFit.fitHeight,
                    width: 50,
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<BatchMaterialState>(
        builder: (context, state, child) {
          if (state.isBusy) {
            return Ploader();
          }
          if (!(state.list != null && state.list.isNotEmpty)) {
            return Center(
              child: Text("No videos available"),
            );
          }
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemCount: state.list.length,
              itemBuilder: (_, index) {
                return _materialCard(context, state.list[index]);
              });
        },
      ),
    );
  }
}
