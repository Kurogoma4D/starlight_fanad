import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:starlight_fanad/animations/main_animation_landscape.dart';
import 'package:starlight_fanad/animations/main_animation_portrait.dart';
import 'package:starlight_fanad/animations/main_lights.dart';

class MainSection extends StatelessWidget {
  const MainSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const MainLights(),
        OrientationLayoutBuilder(
          landscape: (context) => MainAnimationLandscape(
              height: MediaQuery.of(context).size.height),
          portrait: (context) => MainAnimationPortrait(
              height: MediaQuery.of(context).size.height * 0.4),
        ),
      ],
    );
  }
}
