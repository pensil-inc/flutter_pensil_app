import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  Timer(
      {Key key,
      this.duration,
      this.onTimerComplete,
      this.onTimerChanged,
      this.timeTaken})
      : super(key: key);
  final Function(String) onTimerComplete;
  final Function(String) timeTaken;
  final ValueChanged<String> onTimerChanged;
  final int duration;

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> animation;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(minutes: widget.duration));
    animation = StepTween(
      begin: widget.duration * 60, // THIS IS A USER ENTERED NUMBER
      end: 0,
    ).animate(_controller)
      ..addListener(listner);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(animation: animation);
  }

  void listner() {
    Duration anticlockTimer = Duration(seconds: 10 - animation.value);
    String antotimerText =
        '${anticlockTimer.inMinutes.remainder(60).toString()}:${anticlockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    antotimerText = antotimerText.replaceAll("-", "");
    widget.timeTaken(antotimerText + " min");
    print(antotimerText);
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    if (animation.value == 0) {
      _controller.stop();

      widget.onTimerComplete("$timerText time left");
    }
    widget.onTimerChanged("$timerText time left");
  }
}

class Countdown extends AnimatedWidget {
  Countdown({
    Key key,
    this.animation,
  }) : super(key: key, listenable: animation);
  final Animation<int> animation;
  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    // print('animation.value  ${animation.value} ');
    // print('inMinutes ${clockTimer.inMinutes.toString()}');
    // print('inSeconds ${clockTimer.inSeconds.toString()}');
    // print('inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Text("$timerText min left",
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.bold));
  }
}
