class AppLottie {
  static const String path = 'assets/lottie/';
  static const String dice = '${path}dice_lottie.json';
  static const String quiz = '${path}quiz_lottie.json';
  static const String shakePhone = '${path}shake_phone.json';
  static const String diceRoll = '${path}dice_roll.json';
  static const String celebration = '${path}celebration.json';

  static String getPath(String key) {
    switch (key) {
      case 'shake dice':
        return dice;
      case 'quiz':
        return quiz;
      default:
        return '';
    }
  }
}