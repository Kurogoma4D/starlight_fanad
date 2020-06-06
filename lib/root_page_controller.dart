import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootPageController extends ChangeNotifier {
  RootPageController({this.locator}) {
    initialize();
  }

  final baseUrl =
      'https://s3-ap-northeast-1.amazonaws.com/cinema.revuestarlight.com/wordpress/wp-content/uploads/';

  final Locator locator;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final random = Random();

  Map<String, Image> images = {};

  void initialize() async {
    final context =
        locator<GlobalKey<NavigatorState>>().currentState.overlay.context;

    images['title'] = Image.network(baseUrl + '01_rondo_color.png');

    final numbers = List.generate(40, (index) => index + 1);
    numbers.shuffle();

    for (var i = 0; i < 6; i++) {
      final number =
          numbers[i] < 10 ? '0' + numbers[i].toString() : numbers[i].toString();
      images['visual' + i.toString()] =
          Image.network(baseUrl + '05_photo' + number + '.jpg');
    }

    for (final image in images.values) {
      await precacheImage(image.image, context);
    }

    _isLoading = false;
    notifyListeners();
  }
}
