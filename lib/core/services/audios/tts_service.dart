import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../contract/tts_service_contract.dart';

class TtsServiceImpl implements TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  double volume = 1.0;

  @override
  Future<Unit> speak(String text) async {
    final completer = Completer<Unit>();

    _flutterTts.setCompletionHandler(() {
      completer.complete(unit);
    });

    await _flutterTts.speak(text);
    return completer.future;
  }

  @override
  Future<Unit> setVolume(double volume) async {
    this.volume = volume;
    await _flutterTts.setVolume(volume);
    return unit;
  }

  @override
  Future<Unit> init() {
    return setVolume(volume);
  }
}