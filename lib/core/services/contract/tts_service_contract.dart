import 'package:dartz/dartz.dart';

abstract class TtsService {
  Future<Unit> init();
  Future<Unit> speak(String text);
  Future<Unit> setVolume(double volume);
}