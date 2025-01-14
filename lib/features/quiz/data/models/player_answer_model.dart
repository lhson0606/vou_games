import 'dart:convert';

import 'package:vou_games/core/network/json_model.dart';
import 'package:vou_games/features/quiz/domain/entities/player_answer_entity.dart';

class PlayerAnswerModel extends PlayerAnswerEntity implements JsonModel {
  const PlayerAnswerModel(
      {required super.questionNumber, required super.answer});

  @override
  Map<String, dynamic> toJson() {
    return {'questionNumber': questionNumber, 'answer': answer};
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory PlayerAnswerModel.fromPlayerAnswerEntity(PlayerAnswerEntity entity) {
    return PlayerAnswerModel(
      questionNumber: entity.questionNumber,
      answer: entity.answer,
    );
  }
}
