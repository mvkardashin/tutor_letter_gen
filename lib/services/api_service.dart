import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_letter_gen/services/promt_generator.dart';

abstract class ApiServiceImpl {
  Future<String> fetchAiIssues(
      {required String errorPrompt, required String teacherJson});
  Future<List<String>> loadIssue();
}

const iamToken = 'AQVN3RvBwn4uHjeH5ahUvr7Xk-cUoBuny9SKw5KT';
const folderId = 'b1gpn685uog7od48aaiu';

class ApiService implements ApiServiceImpl {
  @override
  Future<String> fetchAiIssues({
    required String errorPrompt,
    required String teacherJson,
  }) async {
    final url = Uri.parse('http://localhost:8080/api/gpt');

    final body = {
      'modelUri': 'gpt://$folderId/yandexgpt', // примерная форма
      'completionOptions': {
        'stream': false,
        'temperature': 0.5,
        'maxTokens': '200',
        'reasoningOptions': {
          'mode': 'DISABLED',
        },
      },
      'messages': [
        {"role": "system", "text": generatePrompt(errorPrompt) + errorPrompt},
        {"role": "user", "text": teacherJson}
      ]
    };
    debugPrint(body.toString());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $iamToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final respJson = jsonDecode(response.body);
      // тут зависит от структуры ответа — надо посмотреть, что возвращает API
      // допустим, там есть поле `alternatives` → массив вариантов, каждый с role/message
      if (respJson['alternatives'] != null &&
          respJson['alternatives'] is List &&
          respJson['alternatives'].isNotEmpty) {
        final first = respJson['alternatives'][0];
        // может быть { "message": { "text": "...", "role": "assistant" } }
        if (first['message'] != null && first['message']['text'] != null) {
          return first['message']['text'];
        }
      }
      // если не нашли текст, вернуть весь JSON как fallback

      debugPrint(response.body);
      return response.body;
    } else {
      throw Exception(
          'Yandex GPT request failed: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<List<String>> loadIssue() async {
    await Future.delayed(const Duration(seconds: 1));
    return ["NATIVE_TUTOR"];
  }
}
