import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/image_viewer.dart';
import 'package:flutter_pensil_app/ui/widget/url_Text.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget(
    this.model, {
    Key key,
  }) : super(key: key);
  final AnnouncementModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: AppTheme.decoration(context)
          .copyWith(color: Theme.of(context).primaryColor),
      child: Row(
        children: [
          Expanded(
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
            flex: 1,
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UrlText(text: model.description),
                  SizedBox(height: 8),
                  if (model.image != null && model.image.isNotEmpty) ...[
                    CachedNetworkImage(imageUrl: model.image, height: 120)
                        .ripple(() {
                      Navigator.push(
                          context, ImageViewer.getRoute(model.image));
                    }),
                    SizedBox(height: 8),
                  ],
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (model.owner != null && model.owner.name != null)
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
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
