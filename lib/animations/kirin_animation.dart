import 'dart:math';

import 'package:flutter/material.dart';

class KirinAnimation extends StatefulWidget {
  const KirinAnimation({Key key}) : super(key: key);

  @override
  _KirinAnimationState createState() => _KirinAnimationState();
}

class _KirinAnimationState extends State<KirinAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: SizedBox(
        width: 64,
        height: 64,
        child: Image.asset('images/04_icon02.png'),
      ),
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
    );
  }
}
