import 'dart:convert';

import 'package:dart_openai/dart_openai.dart';
import 'package:dartz/dartz.dart';
import 'package:vou_games/env/env.dart';
import 'package:vou_games/features/quiz/data/datasources/quiz_ai_mc_datasource_contract.dart';

class QuizOpenAIMCDataSource implements QuizAIMCDataSource {
  final ContextWindow contextWindow = ContextWindow();

  @override
  Future<Unit> init() async {
    OpenAI.apiKey = Env.apiKey;
    //OpenAI.organization = "ORGANIZATION ID";
    OpenAI.requestsTimeOut = const Duration(seconds: 60);
    //OpenAI.showLogs = true;
    //OpenAI.showResponsesLogs = true;
    // var res = await sendSystemMessage("Hello, I am connecting?");
    //
    // if (res.isEmpty) {
    //   print("Error connecting to OpenAI");
    // }

    return unit;
  }

  @override
  void newSession() {
    contextWindow.messages.clear();
    sendSystemMessage(
        "You are a joyful MC for a quiz game now. The system will send you system messages to inform you about the state of the game. You should return the text that you want to speak to the player. It will be speak out loud by the system.");
  }

  Future<List<String>> addNewMessage(
      OpenAIChatMessageRole role, String message) async {
    final chatCompletion = await sendMessage(role, message);
    final List<String> responses = getMessages(chatCompletion);
    saveAssistantMessage(responses);
    return responses;
  }

  @override
  Future<List<String>> sendSystemMessage(String message) {
    return addNewMessage(OpenAIChatMessageRole.system, message);
  }

  @override
  Future<List<String>> sendUserMessage(String message) async {
    return addNewMessage(OpenAIChatMessageRole.user, message);
  }

  List<String> getMessages(OpenAIChatCompletionModel chatCompletion) {
    List<String> responses = [];
    for (var c in chatCompletion.choices) {
      if (c.message.content != null &&
          c.message.content!.isNotEmpty &&
          c.message.content!.first.text != null) {
        final json =
            jsonDecode(c.message.content!.first.text!) as Map<String, dynamic>;
        String text = json['json'];
        responses.add(text);
      }
    }
    return responses;
  }

  Future<OpenAIChatCompletionModel> sendMessage(
      OpenAIChatMessageRole role, String message) async {
    final newSystemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          jsonEncode({"json": message}),
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    contextWindow.addMessage(newSystemMessage);

    // the actual request.
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo-1106",
      responseFormat: {"type": "json_object"},
      seed: 6,
      messages: contextWindow.messages,
      temperature: 0.2,
      maxTokens: 500,
    );

    return chatCompletion;
  }

  void saveAssistantMessage(List<String> responses) {
    for (var response in responses) {
      final newSystemMessage = OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            jsonEncode({"json": response}),
          ),
        ],
        role: OpenAIChatMessageRole.assistant,
      );
      contextWindow.addMessage(newSystemMessage);
    }
  }
}

class ContextWindow {
  final List<OpenAIChatCompletionChoiceMessageModel> messages = [];

  void addMessage(OpenAIChatCompletionChoiceMessageModel message) {
    messages.add(message);
  }
}
