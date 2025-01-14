class AppLottie {
  static const String path = 'assets/lottie/';
  static const String dice = '${path}dice_lottie.json';
  static const String quiz = '${path}quiz_lottie.json';
  static const String shakePhone = '${path}shake_phone.json';
  static const String diceRoll = '${path}dice_roll.json';
  static const String celebration = '${path}celebration.json';
  static const String femaleMcTalking = '${path}female_mc_talking.json';

  static String getPath(String key) {
    if (key.toLowerCase().contains("quiz")){
      return quiz;
    } else if (key.toLowerCase().contains("shake")){
      return shakePhone;
    } else {
      return dice;
    }
  }
}