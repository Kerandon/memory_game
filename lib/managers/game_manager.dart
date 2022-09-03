import 'package:flutter/material.dart';
import 'package:memory_game/managers/audio_manager.dart';
import 'package:memory_game/models/word.dart';

class GameManager extends ChangeNotifier {
  Map<int, Word> tappedWords = {};
  bool canFlip = false,
      reverseFlip = false,
      ignoreTaps = false,
      roundCompleted = false;
  List<int> answeredWords = [];

  tileTapped({required int index, required Word word}) {
    ignoreTaps = true;
    if (tappedWords.length <= 1) {
      tappedWords.addEntries([MapEntry(index, word)]);
      canFlip = true;
    } else {
      canFlip = false;
    }

    notifyListeners();
  }

  onAnimationCompleted({required bool isForward}) async {
    if (tappedWords.length == 2) {
      if (isForward) {
        if (tappedWords.entries.elementAt(0).value.text ==
            tappedWords.entries.elementAt(1).value.text) {
          answeredWords.addAll(tappedWords.keys);
          if (answeredWords.length == 6) {
            await AudioManager.playAudio('Round');
            roundCompleted = true;
          } else {
            await AudioManager.playAudio('Correct');
          }
          tappedWords.clear();
          canFlip = true;
          ignoreTaps = false;
        } else {
          await AudioManager.playAudio('Incorrect');
          reverseFlip = true;
        }
      } else {
        reverseFlip = false;
        tappedWords.clear();
        ignoreTaps = false;
      }
    } else {
      canFlip = false;
      ignoreTaps = false;
    }

    notifyListeners();
  }
}
