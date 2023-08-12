import 'package:flutter/material.dart';
import '../Fonts/AppFonts.dart';
import 'AppText.dart';

class AnimatedTextWidget extends StatefulWidget {
  String text;
  double textSize;
  Color textColor;

  AnimatedTextWidget(
      {Key? key,
      required this.text,
      this.textSize = 18,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
 // final animatedTextRefrence = GlobalKey<_AnimatedTextWidgetState>();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  );

  @override
  void dispose() {
    // TODO: implement dispose
   // animatedTextRefrence.currentState?.dispose();
   // Scaffold.geometryOf(context);
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _animation,
        child: AppText(
          text: widget.text,
          size: widget.textSize,
          color: widget.textColor,
          fontFamily: Weights.londrinaRegular,
        ));
  }
}
