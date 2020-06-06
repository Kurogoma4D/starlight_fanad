import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlight_fanad/animations/init_spotlight.dart';
import 'package:starlight_fanad/animations/text_animation.dart';

class InitSection extends StatelessWidget {
  const InitSection._({Key key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        Provider<InitSectionController>(
          create: (context) => InitSectionController(),
          dispose: (_, controller) => controller.dispose(),
        ),
      ],
      child: const InitSection._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: const TextAnimationDesktop(),
            ),
          ),
        ),
        Positioned(
          top: -60,
          left: 0,
          child: const InitSpotlight(),
        )
      ],
    );
  }
}

class InitSectionController {
  InitSectionController({this.locator});

  final Locator locator;
  final StreamController<bool> textChain = StreamController<bool>.broadcast();

  void dispose() {
    textChain.close();
  }
}
