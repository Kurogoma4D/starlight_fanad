import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlight_fanad/animation_manager.dart';
import 'package:starlight_fanad/animations/kirin_animation.dart';
import 'package:starlight_fanad/root_page_controller.dart';
import 'package:starlight_fanad/sections/end_section.dart';
import 'package:starlight_fanad/sections/init_section.dart';
import 'package:starlight_fanad/sections/main_section.dart';

class RootPage extends StatelessWidget {
  const RootPage._({Key key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnimationManager()),
        ChangeNotifierProvider(
            create: (context) => RootPageController(locator: context.read))
      ],
      child: const RootPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RootPageController>();
    return Scaffold(
      backgroundColor: Color(0xff161616),
      body: controller.isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const KirinAnimation(),
                const SizedBox(height: 16),
                Text(
                  'ロード中',
                  style: TextStyle(
                    fontFamily: 'NotoSerif',
                    color: Colors.white,
                  ),
                )
              ],
            ))
          : const AnimationSwitch(),
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
        return InitSection.wrapped();

      case AnimationState.MAIN:
        return const MainSection();

      case AnimationState.END:
        return const EndSection();

      default:
        return Container();
    }
  }
}
