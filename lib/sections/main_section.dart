import 'package:flutter/material.dart';
import 'package:starlight_fanad/animations/main_animation.dart';
import 'package:starlight_fanad/animations/main_lights.dart';

class MainSection extends StatelessWidget {
  const MainSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const MainLights(),
        MainAnimation(height: MediaQuery.of(context).size.height * 0.8),
      ],
    );
  }
}
