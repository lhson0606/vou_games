abstract class AudioService {
  void soundOn();
  void soundOff();
  bool isPlaying();
  void playAudio(String fileName);
  void stopAudio();
  void doTest();
  void setVolume(double volume);
  void init();
}