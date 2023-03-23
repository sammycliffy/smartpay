import 'package:flutter/material.dart';

class OTPTimer extends StatefulWidget {
  int time;
  double fontSize;
  Color timeColor;
  OTPTimer(
      {Key? key,
      this.time = 600,
      this.fontSize = 14,
      this.timeColor = Colors.black})
      : super(key: key);
  @override
  OTPTimerState createState() => OTPTimerState();
}

class OTPTimerState extends State<OTPTimer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller!,
        builder: (BuildContext context, Widget? child) {
          return Text(
            timerString,
            style:
                TextStyle(fontSize: widget.fontSize, color: widget.timeColor),
          );
        });
  }

  String get timerString {
    Duration duration = _controller!.duration! * _controller!.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else if (duration.inMinutes < 1) {
      return (duration.inSeconds % 60).toString().padLeft(2, '0');
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  // Center(
  //                       child: Text(
  //                         "Resend Code in 30 secs",
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .bodyMedium
  //                             ?.copyWith(fontWeight: FontWeight.w700),
  //                       ),
  //                     ),
  // timeUp() {
  //   return const TextButton(
  //     onPressed: null,
  //     child: Text("Resend"),
  //   );
  // }

  Duration get duration {
    Duration duration = _controller!.duration!;
    return duration;
  }

  _initTimer() {
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.time))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            // _hideResendButton = !_hideResendButton;
          });
        }
      });
    _controller!
        .reverse(from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
    // _startCountdown();
  }

  Future<void> startCountdown() async {
    _controller!
        .reverse(from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
  }

  Future<void> restart() async {
    _controller!.value = 0.0;
    startCountdown();
  }
}
