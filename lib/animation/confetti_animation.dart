import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiAnimation extends StatefulWidget {
  const ConfettiAnimation({required this.animate, Key? key}) : super(key: key);

  final bool animate;

  @override
  State<ConfettiAnimation> createState() => _ConfettiAnimationState();
}

class _ConfettiAnimationState extends State<ConfettiAnimation> {
  final _controller = ConfettiController(
    duration: const Duration(milliseconds: 1500),
  );

  @override
  void didUpdateWidget(covariant ConfettiAnimation oldWidget) {
    if (widget.animate) {
      _controller.play();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -1.50),
      child: ConfettiWidget(
          maximumSize: const Size(30, 100),
          minimumSize: const Size(10, 30),
          gravity: 0.50,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 60,
          confettiController: _controller),
    );
  }
}
