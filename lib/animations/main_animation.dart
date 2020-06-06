import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:starlight_fanad/animation_manager.dart';
import 'package:provider/provider.dart';

class MainAnimation extends StatefulWidget {
  MainAnimation({Key key, this.height}) : super(key: key);

  final height;

  @override
  _MainAnimationState createState() => _MainAnimationState();
}

class _MainAnimationState extends State<MainAnimation>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;

  final words = [
    '私だけの',
    '永遠の舞台を',
    'もう一度…',
    '歌って',
    '踊って',
    '奪い合いましょう？',
  ];

  List<Image> images = [];
  double _opacity = 1;

  @override
  void initState() {
    _scrollController = ScrollController();

    final numbers = List.generate(40, (index) => index + 1);
    numbers.shuffle();

    for (var i = 0; i < words.length; i++) {
      images.add(Image.asset('images/05_photo${numbers[i].toString()}.jpg'));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _scrollController.animateTo(
        widget.height * (words.length + 1),
        duration: const Duration(seconds: 40),
        curve: Curves.linear,
      );
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _opacity = 0);
      await Future.delayed(const Duration(milliseconds: 1500));
      context.read<AnimationManager>().state = AnimationState.END;
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size);
    final style = deviceType == DeviceScreenType.desktop
        ? Theme.of(context).textTheme.headline4.copyWith(
              fontFamily: 'NotoSerif',
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 1.6,
            )
        : Theme.of(context).textTheme.headline6.copyWith(
              fontFamily: 'NotoSerif',
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 1.6,
            );
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1500),
          opacity: _opacity,
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: words.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) {
                return SizedBox(height: widget.height);
              }

              final index = i - 1;
              return SizedBox(
                height: widget.height,
                child: index % 2 == 0
                    ? Row(children: <Widget>[
                        Flexible(child: images[index]),
                        const SizedBox(width: 64),
                        Text(words[index], style: style),
                      ])
                    : Row(children: <Widget>[
                        Text(words[index], style: style),
                        const SizedBox(width: 64),
                        Flexible(child: images[index]),
                      ]),
              );
            },
            separatorBuilder: (context, _) {
              return OrientationLayoutBuilder(
                landscape: (context) => const SizedBox(height: 128),
                portrait: (context) => const SizedBox(height: 8),
              );
            },
          ),
        ),
      ),
    );
  }
}
