import 'package:flutter/material.dart';

class ThumbnailPreview extends StatelessWidget {
  const ThumbnailPreview({Key key, this.title, this.url}) : super(key: key);
  final String title;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(4),
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Opacity(
                opacity: 0.5,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    url != null ? url : "",
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: title != null
                    ? Text(
                        title,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    : Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}