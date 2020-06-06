import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:starlight_fanad/animations/kirin_animation.dart';
import 'package:starlight_fanad/constants.dart';
import 'package:starlight_fanad/root_page_controller.dart';
import 'package:provider/provider.dart';

class MainLights extends StatefulWidget {
  const MainLights({Key key}) : super(key: key);

  @override
  _MainLightsState createState() => _MainLightsState();
}

class _MainLightsState extends State<MainLights>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _timeLine();

    super.initState();
  }

  void _timeLine() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() => _opacity = 1);

    await Future.delayed(const Duration(seconds: 30));
    setState(() => _opacity = 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCirc,
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: OrientationLayoutBuilder(
              landscape: (context) => CustomPaint(
                painter: _LightPainter(radius: 120),
              ),
              portrait: (context) => CustomPaint(
                painter: _LightPainter(radius: 60),
              ),
            ),
          ),
          Center(child: const KirinAnimation()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _LightPainter extends CustomPainter {
  _LightPainter({this.radius});

  final double radius;

  final gradient = RadialGradient(
    center: const Alignment(0, 0),
    radius: 0.7,
    colors: [Colors.white.withOpacity(0.3), Colors.transparent],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = BANANA_COLOR
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20.0)
      ..style = PaintingStyle.fill;

    final baseWidth = size.width / 6;

    for (var i = 0; i < 6; i++) {
      final lightOffset = Offset(
        baseWidth * i + baseWidth / 2,
        size.height / 2,
      );

      canvas.drawCircle(lightOffset, 20, paint);

      final rect = Rect.fromCircle(center: lightOffset, radius: radius);

      final outerPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20.0)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(lightOffset, radius, outerPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
