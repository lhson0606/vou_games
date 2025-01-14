import 'package:dartz/dartz.dart';
import 'package:vou_games/core/services/contract/tts_service_contract.dart';

class TextToSpeechUsecase {
  final TtsService ttsService;

  TextToSpeechUsecase({required this.ttsService});

  Future<Unit> call(String text) {
    return ttsService.speak(text);
  }
}
