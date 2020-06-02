import 'package:flutter/material.dart';

class DelayedCurve extends Curve {
  const DelayedCurve();

  @override
  double transform(double t) {
    return (t.clamp(0.2, 0.8) - 0.2) / 0.6;
  }
}

class TextAnimation extends StatefulWidget {
  @override
  _TextAnimationState createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation>
    with TickerProviderStateMixin {
  AnimationController _primaryController;
  AnimationController _secondaryController;
  Animation<double> _primaryAnimation;
  Animation<double> _secondaryAnimation;

  String _primaryText = '';
  String _secondaryText = '';
  final primary = 'あの星を';
  final secondary = '掴むのはだぁれ？';

  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    _primaryController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _primaryAnimation = Tween<double>(begin: 0, end: primary.length.toDouble())
        .chain(CurveTween(curve: const DelayedCurve()))
        .animate(_primaryController)
          ..addListener(
            () => setState(() {
              _primaryText =
                  primary.substring(0, _primaryAnimation.value.toInt());
            }),
          )
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _secondaryController.forward();
            }
          });

    _secondaryController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _secondaryAnimation =
        Tween<double>(begin: 0, end: secondary.length.toDouble())
            .chain(CurveTween(curve: const DelayedCurve()))
            .animate(_secondaryController)
              ..addListener(
                () => setState(() {
                  _secondaryText =
                      secondary.substring(0, _secondaryAnimation.value.toInt());
                }),
              )
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  _opacity = 0;
                }
              });

    _primaryController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headline3.copyWith(
          fontFamily: 'NotoSerif',
          fontWeight: FontWeight.w700,
          color: Colors.white,
        );
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 650),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_primaryText, style: style),
          const SizedBox(width: 16),
          Text(_secondaryText, style: style),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }
}
