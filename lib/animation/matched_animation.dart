import 'package:flutter/material.dart';

class MatchedAnimation extends StatefulWidget {
  const MatchedAnimation(
      {required this.child,
      required this.animate,
      required this.numberOfWordsAnswered,
      Key? key})
      : super(key: key);

  final Widget child;
  final bool animate;
  final int numberOfWordsAnswered;

  @override
  State<MatchedAnimation> createState() => _MatchedAnimationState();
}

class _MatchedAnimationState extends State<MatchedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shake, _scale;

  Color _defaultColor = Colors.blueAccent, _correctColor = Colors.green;
  bool _correctColorIsSet = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);

    _shake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 0.12), weight: 3),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.12, end: -0.08), weight: 5),
      TweenSequenceItem(
          tween: Tween<double>(begin: -0.08, end: 0.04), weight: 5),
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.04, end: 0.00), weight: 6),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.90), weight: 7),
      TweenSequenceItem(tween: Tween<double>(begin: 0.90, end: 1.0), weight: 3),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant MatchedAnimation oldWidget) {
    if (widget.animate) {
      if (!_correctColorIsSet) {
        if (widget.numberOfWordsAnswered == 4) {
          _correctColor = Colors.pink;
        }
        if (widget.numberOfWordsAnswered == 6) {
          _correctColor = Colors.amber;
        }
      }

      _correctColorIsSet = true;
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateZ(_shake.value)
          ..scale(_scale.value)
          ..setEntry(3, 2, 0.003),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: widget.animate ? _correctColor : _defaultColor,
            ),
            child: widget.child),
      ),
    );
  }
}
