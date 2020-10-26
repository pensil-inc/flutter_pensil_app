import 'dart:async';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class VideoPlayerPage2 extends StatefulWidget {
  final String path;
  final String title;

  const VideoPlayerPage2({Key key, this.path, this.title}) : super(key: key);

  static MaterialPageRoute getRoute(String path, {String title}) {
    return MaterialPageRoute(
        builder: (_) => VideoPlayerPage2(
              path: path,
              title: title,
            ));
  }

  @override
  _VideoPlayerPage2State createState() => _VideoPlayerPage2State();
}

class _VideoPlayerPage2State extends State<VideoPlayerPage2> {
  BetterPlayerController _betterPlayerController;
  StreamController<bool> _fileVideoStreamController = StreamController.broadcast();
  bool _fileVideoShown = false;

  Future<BetterPlayerController> _setupDefaultVideoData() async {
    var dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.NETWORK, "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
        resolutions: {
          "LOW": "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
          "MEDIUM": "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4",
          "LARGE": "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4",
          "EXTRA_LARGE": "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4"
        });
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableProgressText: true,
            enablePlaybackSpeed: true,
            enableSubtitles: true,
          ),
        ),
        betterPlayerDataSource: dataSource);
    _betterPlayerController.addEventsListener((event) {
      print("Better player event: ${event.betterPlayerEventType}");
    });
    return _betterPlayerController;
  }

  Future<BetterPlayerController> _setupFileVideoData() async {
    // final directory = await getApplicationDocumentsDirectory();

    var dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.NETWORK,
      "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
    );
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(),
      betterPlayerDataSource: dataSource,
    );

    return _betterPlayerController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: PColors.black,
          child: Text(widget.title ?? "Document"),
        ),
      ),
      body: ListView(children: [
        _buildDefaultVideo(),
      ]),
    );
  }

  Widget _buildDefaultVideo() {
    return FutureBuilder<BetterPlayerController>(
      future: _setupDefaultVideoData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: snapshot.data,
            ),
          );
        }
      },
    );
  }

  // Widget _buildShowFileVideoButton() {
  //   return Column(children: [
  //     RaisedButton(
  //       child: Text("Show video from file"),
  //       onPressed: () {
  //         _fileVideoShown = !_fileVideoShown;
  //         _fileVideoStreamController.add(_fileVideoShown);
  //       },
  //     ),
  //     _buildFileVideo()
  //   ]);
  // }


  Widget _buildFileVideo() {
    return StreamBuilder<bool>(
      stream: _fileVideoStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot?.data == true) {
          return FutureBuilder<BetterPlayerController>(
            future: _setupFileVideoData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: BetterPlayer(
                    controller: snapshot.data,
                  ),
                );
              }
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  void dispose() {
    _fileVideoStreamController.close();
    super.dispose();
  }
}
