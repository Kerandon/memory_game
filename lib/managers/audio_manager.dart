import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final player = AudioPlayer();

  static Future playAudio(String audio) async {
    await player.play(AssetSource('audio/$audio.mp3'));
  }
}
