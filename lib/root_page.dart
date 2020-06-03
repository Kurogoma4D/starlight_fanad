import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlight_fanad/animation_manager.dart';
import 'package:starlight_fanad/animations/text_animation.dart';
import 'package:starlight_fanad/sections/init_section.dart';

class RootPage extends StatelessWidget {
  const RootPage._({Key key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnimationManager()),
      ],
      child: const RootPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161616),
      body: Center(
        child: TextAnimationDesktop(),
      ),
    );
  }
}

class AnimationSwitch extends StatelessWidget {
  const AnimationSwitch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((AnimationManager manager) => manager.state);
    switch (state) {
      case AnimationState.INIT:
        return const InitSection();

      case AnimationState.MAIN:
        return Container();

      case AnimationState.END:
        return Container();

      default:
        return Container();
    }
  }
}
