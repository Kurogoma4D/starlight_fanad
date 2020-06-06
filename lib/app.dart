import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'root_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return Provider<GlobalKey<NavigatorState>>.value(
      value: navigatorKey,
      child: MaterialApp(
        title: 'スタァライトファンアド | Kurogoma4D',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: navigatorKey,
        home: RootPage.wrapped(),
      ),
    );
  }
}
