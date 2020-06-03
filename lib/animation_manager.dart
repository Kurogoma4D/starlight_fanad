import 'package:flutter/material.dart';

enum AnimationState {
  INIT,
  MAIN,
  END,
}

class AnimationManager extends ChangeNotifier {
  AnimationManager();

  AnimationState _state = AnimationState.INIT;

  AnimationState get state => _state;

  set state(AnimationState newState) {
    _state = newState;
    notifyListeners();
  }
}
