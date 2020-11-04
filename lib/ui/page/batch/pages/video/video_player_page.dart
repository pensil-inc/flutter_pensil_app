import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:yoyo_player/yoyo_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String path;
  final String title;

  const VideoPlayerPage({Key key, this.path, this.title}) : super(key: key);

  static MaterialPageRoute getRoute(String path, {String title}) {
    return MaterialPageRoute(
        builder: (_) => VideoPlayerPage(
              path: path,
              title: title,
            ));
  }

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool fullscreen = false;
  @override
  void initState() {
    super.initState();
    log("Now playing: ${widget.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullscreen == false
          ? AppBar(
              title: Title(
                color: PColors.black,
                child: Text(widget.title ?? "Document"),
              ),
            )
          : null,
      body: Column(
        children: [
          YoYoPlayer(
            aspectRatio: 16 / 9,
            url: widget.path,
            // "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            // "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
            // "https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101",
            // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
            videoStyle: VideoStyle(
                play: Icon(Icons.play_arrow),
                pause: Icon(Icons.pause),
                fullscreen: Icon((Icons.fullscreen)),
                forward: Icon(Icons.skip_next),
                playedColor: PColors.primary,
                qualitystyle: TextStyle(color: Colors.white),
                backward: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.ac_unit),
                )),
            videoLoadingStyle: VideoLoadingStyle(
              loading: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Ploader(
                      stroke: 3,
                    ),
                    SizedBox(height: 10),
                    Text("Loading video"),
                  ],
                ),
              ),
            ),
            onfullscreen: (t) {
              setState(() {
                fullscreen = t;
              });
            },
          ),
        ],
      ),
    );
  }
}
