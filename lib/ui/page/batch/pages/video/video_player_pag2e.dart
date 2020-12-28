import 'dart:async';
import 'dart:developer';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      ),
    );
  }

  @override
  _VideoPlayerPage2State createState() => _VideoPlayerPage2State();
}

class _VideoPlayerPage2State extends State<VideoPlayerPage2> {
  BetterPlayerController _betterPlayerController;
  StreamController<bool> _fileVideoStreamController =
      StreamController.broadcast();
  bool _fileVideoShown = false;
  void initState() {
    super.initState();
    log("Now playing: ${widget.path}");
  }

  Future<BetterPlayerController> _setupDefaultVideoData() async {
    var dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.path,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        maxCacheSize: 1e+8.toInt(),
        useCache: true,
      ),
    );
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableProgressText: true,
          enablePlaybackSpeed: true,
          enableSubtitles: true,
          enableSkips: false,
          showControlsOnInitialize: false,
        ),
        fit: BoxFit.contain,
        startAt: const Duration(milliseconds: 1000),
        looping: true,
        autoPlay: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ],
      ),
      betterPlayerDataSource: dataSource,
    );
    // _betterPlayerController.addEventsListener((event) {
    //   print("Better player event: ${event.betterPlayerEventType}");
    // });
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
          return BetterPlayer(
            controller: snapshot.data,
          );
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
