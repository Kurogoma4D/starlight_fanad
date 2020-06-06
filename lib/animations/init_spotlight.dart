import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:starlight_fanad/constants.dart';
import 'package:starlight_fanad/sections/init_section.dart';
import 'package:provider/provider.dart';

class InitSpotlight extends StatefulWidget {
  const InitSpotlight({Key key}) : super(key: key);

  @override
  _InitSpotlightState createState() => _InitSpotlightState();
}

class _InitSpotlightState extends State<InitSpotlight>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation lightAnimation;
  StreamSink _chainSink;

  double _opacity = 0;
  List<Offset> particleOffsets = [];
  final random = Random();

  @override
  void initState() {
    particleOffsets = List<Offset>.generate(
      20,
      (_) => Offset(random.nextDouble(), random.nextDouble()),
    );

    _chainSink = context.read<InitSectionController>().textChain.sink;
    _controller = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..addListener(() => setState(() {}));

    _controller.forward();

    _timeLine();

    super.initState();
  }

  void _timeLine() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() => _opacity = 1);
    await Future.delayed(const Duration(milliseconds: 2000));
    _chainSink.add(true);
    await Future.delayed(const Duration(milliseconds: 4000));
    setState(() => _opacity = 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCirc,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3 * 2,
        child: CustomPaint(
          painter: LightPainter(
            animationValue: _controller.value,
            particleOffsets: particleOffsets,
          ),
        ),
      ),
    );
  }
}

class LightPainter extends CustomPainter {
  LightPainter({this.animationValue, this.particleOffsets});

  final gradient = RadialGradient(
    center: const Alignment(0, -0.7),
    radius: 0.9,
    colors: [BANANA_COLOR, Colors.transparent],
  );

  final animationValue;
  final particleOffsets;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width / 3 * 2, size.height)
      ..lineTo(size.width / 3, size.height)
      ..lineTo(size.width / 2, 0);

    canvas.drawPath(path, paint);

    for (Offset offset in particleOffsets) {
      final particlePaint = Paint()
        ..color = BANANA_COLOR
            .withOpacity(sin(animationValue * offset.dy * 100) * 0.4 + 0.5)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0 * offset.dy)
        ..style = PaintingStyle.fill;

      final moved = offset.translate(
        offset.dx,
        offset.dy - animationValue,
      );

      canvas.drawPath(_getParticlePath(moved.scale(size.width, size.height)),
          particlePaint);
    }
  }

  Path _getParticlePath(Offset offset) {
    return Path()
      ..moveTo(offset.dx, offset.dy - 20)
      ..quadraticBezierTo(offset.dx, offset.dy, offset.dx + 10, offset.dy)
      ..quadraticBezierTo(offset.dx, offset.dy, offset.dx, offset.dy + 20)
      ..quadraticBezierTo(offset.dx, offset.dy, offset.dx - 10, offset.dy)
      ..quadraticBezierTo(offset.dx, offset.dy, offset.dx, offset.dy - 20);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
