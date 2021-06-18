import 'package:audioplayers/audioplayers.dart';

final player = AudioCache();

void answerSound(bool correct) {
  if (correct) {
    player.play('audio/correct.wav', volume: .7);
  } else {
    player.play('audio/incorrect.mp3', volume: 1.0);
  }
}

void finishSound() {
  player.play('audio/finish.mp3', volume: 1.0);
}
