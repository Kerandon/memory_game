import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memory_game/animation/flip_animation.dart';
import 'package:memory_game/managers/game_manager.dart';
import 'package:memory_game/animation/matched_animation.dart';
import 'package:memory_game/animation/spin_animation.dart';
import 'package:memory_game/models/word.dart';
import 'package:provider/provider.dart';

class WordTile extends StatelessWidget {
  const WordTile({
    required this.index,
    required this.word,
    Key? key,
  }) : super(key: key);

  final int index;
  final Word word;

  @override
  Widget build(BuildContext context) {
    return SpinAnimation(
      child: Consumer<GameManager>(
        builder: (_, notifier, __) {
          bool animate = checkAnimationRun(notifier);

          return GestureDetector(
            onTap: () {
              if (!notifier.ignoreTaps &&
                  !notifier.answeredWords.contains(index) &&
                  !notifier.tappedWords.containsKey(index)) {
                notifier.tileTapped(index: index, word: word);
              }
            },
            child: FlipAnimation(
              delay: notifier.reverseFlip ? 1500 : 0,
              reverse: notifier.reverseFlip,
              animationCompleted: (isForward) {
                notifier.onAnimationCompleted(isForward: isForward);
              },
              animate: animate,
              word: MatchedAnimation(
                numberOfWordsAnswered: notifier.answeredWords.length,
                animate: notifier.answeredWords.contains(index),
                child: Container(
                    padding: const EdgeInsets.all(16),
                    child: word.displayText
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(pi),
                                child: Text(word.text)))
                        : Image.network(word.url)),
              ),
            ),
          );
        },
      ),
    );
  }

  bool checkAnimationRun(GameManager notifier) {
    bool animate = false;

    if (notifier.canFlip) {
      if (notifier.tappedWords.isNotEmpty &&
          notifier.tappedWords.keys.last == index) {
        animate = true;
      }
      if (notifier.reverseFlip && !notifier.answeredWords.contains(index)) {
        animate = true;
      }
    }
    return animate;
  }
}
