import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memory_game/main.dart';
import 'package:memory_game/animation/spin_animation.dart';

const messages = ['Awesome!', 'Fantastic!', 'Nice!', 'Great!'];

class ReplayPopUp extends StatelessWidget {
  const ReplayPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Random().nextInt(messages.length);
    String message = messages[r];

    return SpinAnimation(
      child: AlertDialog(
        title: Text(
          message,
          textAlign: TextAlign.center,
        ),
        content: const Text(
          '🥳',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const MyApp()),
                        (route) => false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Replay!'),
                  )))
        ],
      ),
    );
  }
}
