import 'package:flutter/material.dart';

class SpinAnimation extends StatefulWidget {
  const SpinAnimation({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  State<SpinAnimation> createState() => _SpinAnimationState();
}

class _SpinAnimationState extends State<SpinAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted && !_controller.isAnimating) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
      child: RotationTransition(
        turns: CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
        child: widget.child,
      ),
    );
  }
}
