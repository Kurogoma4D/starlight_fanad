import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlight_fanad/animation_manager.dart';

class EndSection extends StatefulWidget {
  const EndSection({Key key}) : super(key: key);

  @override
  _EndSectionState createState() => _EndSectionState();
}

class _EndSectionState extends State<EndSection> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _opacity = 1);
  }

  void _onPressedRepeat() async {
    setState(() => _opacity = 0);
    await Future.delayed(const Duration(milliseconds: 1500));
    context.read<AnimationManager>().state = AnimationState.INIT;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 1200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: FractionallySizedBox(
                widthFactor: 0.4,
                child: Image.asset('images/01_rondo_color.png'),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '©Project Revue Starlight',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 60),
            IconButton(
              onPressed: _onPressedRepeat,
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            Text(
              'もう一度見る',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'NotoSerif',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
