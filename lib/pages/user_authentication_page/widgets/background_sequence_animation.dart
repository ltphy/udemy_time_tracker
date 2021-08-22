import 'package:flutter/material.dart';

class BackgroundSequenceAnimation extends StatefulWidget {
  @override
  _BackgroundSequenceAnimationState createState() =>
      _BackgroundSequenceAnimationState();
}

class _BackgroundSequenceAnimationState
    extends State<BackgroundSequenceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = this
        ._controller
        .drive(ColorTween(begin: Colors.red, end: Colors.green));
    this._controller..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.animation,
      builder: (context, child) {
        return Container(
          width: 150,
          height: 150,
          color: animation.value,
          child: Text('hello'),
        );
      },
    );
  }
}
