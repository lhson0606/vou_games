import 'package:audioplayers/audioplayers.dart';
import 'package:vou_games/configs/audios/app_audios.dart';
import 'package:vou_games/core/services/contract/audio_service_contract.dart';

class AudioServiceImpl extends AudioService {
  final AudioPlayer player = AudioPlayer();
  bool isSoundEnabled = true;
  double volume = 0.5;

  @override
  bool isPlaying() {
    return player.state == PlayerState.playing;
  }

  @override
  void playAudio(String fileName) {
    if (isSoundEnabled) {
      final removedAssetsPrefix = fileName.replaceFirst('assets/', '');
      player.play(AssetSource(removedAssetsPrefix));
    }
  }

  @override
  void soundOff() {
    isSoundEnabled = false;

    if (isPlaying()) {
      player.stop();
    }
  }

  @override
  void soundOn() {
    isSoundEnabled = true;
  }

  @override
  void stopAudio() {
    player.stop();
  }

  @override
  void doTest() {
    playAudio(AppAudios.waiting);
  }

  @override
  void setVolume(double volume) {
    this.volume = volume;
    player.setVolume(volume);
  }

  @override
  void init() {
    setVolume(volume);
  }
}
