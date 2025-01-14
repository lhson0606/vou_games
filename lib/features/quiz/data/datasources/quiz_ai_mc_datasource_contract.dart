import 'package:dartz/dartz.dart';

abstract class QuizAIMCDataSource {
  Future<Unit> init();
  void newSession();
  Future<List<String>> sendUserMessage(String message);
  Future<List<String>> sendSystemMessage(String message);
}