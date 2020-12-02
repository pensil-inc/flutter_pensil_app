import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/widget/secondary_app_bar.dart';

class ImageViewer extends StatelessWidget {
  static MaterialPageRoute getRoute(String path) {
    return MaterialPageRoute(
      builder: (_) => ImageViewer(
        path: path,
      ),
    );
  }

  const ImageViewer({Key key, this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(""),
      body: Container(
        child: Center(
          child: InteractiveViewer(
            minScale: .3,
            maxScale: 5,
            child: CachedNetworkImage(imageUrl: path),
          ),
        ),
      ),
    );
  }
}
