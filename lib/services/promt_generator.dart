// import 'package:tutor_letter_gen/data/aiIssues.dart';
import 'package:tutor_letter_gen/models/issue.dart';
// import 'package:tutor_letter_gen/models/teacher/teacher.dart';
import 'package:tutor_letter_gen/models/teacher/teacher_group.dart';

const String systemPrompt = """
         Ты — помощник модератора анкет репетиторов.  
        У тебя есть список возможных ошибок в формате:
        - code: уникальный код ошибки
        - prompt: текстовое описание, по каким признакам определяется ошибка

        Тебе будет дана анкета репетитора (текст).
        Твоя задача: внимательно проверить анкету по каждому описанию ошибки (prompt).
        Если ошибка действительно есть в анкете — добавь её code в список результатов.
        Если ошибки нет — не добавляй.

        ⚠️ ВАЖНО:
        - Ориентируйся строго на описание ошибки.
        - Не придумывай новых ошибок.
        - Выводи только чистый JSON-массив строк.
        - Не оборачивай массив в строку, не добавляй экранирование и обратные слэши.
        - Ответ всегда должен начинаться с `[` и заканчиваться `]`.
        - Если ошибок нет → [].
        Пример вывода:
        ["BAD_PHOTO", "NATIVE_TUTOR"]
        
        Пример некорректного вывода:
        - **BAD_PHOTO**
        - "NATIVE_TUTOR"
        или
        {{
        "codes": ["BAD_PHOTO"]
        }}
        ---

        Список ошибок:
        """;

String errors() {
  List<Issue> aiIssuesLoaded = [];
  String rules = aiIssuesLoaded
      .map((e) => '{prompt: ${e.prompt}, code: ${e.code}}')
      .join('\n');
  return rules;
}

String generatePrompt(String errors) {
  String prompt = '$systemPrompt$errors\n---\n Анкета репетитора:\n';
  return prompt;
}

const String systemPersonalPrompt = """
  Тебе дан текст анкеты и список правил (каждое правило имеет code и описание).
   Задача:
- Для каждого правила проверь, соответствует ли анкета его описанию.
- Если соответствует → добавь code в итоговый список.
- Если не соответствует → не добавляй.

        ⚠️ ВАЖНО:
        - Ориентируйся строго на описание ошибки.
        - Не придумывай новых ошибок.
        - Выводи только чистый JSON-массив строк.
        - Не оборачивай массив в строку, не добавляй экранирование и обратные слэши.
        - Ответ всегда должен начинаться с `[` и заканчиваться `]`.
        - Если ошибок нет → [].
        Пример вывода:
        ["BAD_PHOTO", "NATIVE_TUTOR"]
        ---
        Список ошибок:
        """;

String generatePersonalPrompt(String errors) {
  String prompt = '$systemPersonalPrompt$errors\n---\n Данные\n';
  return prompt;
}

String userPromptTime({
  required bool isRemote,
  required bool isLocal,
  required bool isDeparture,
  required String remoteTime,
  required String localTime,
  required String departureTime,
  required List<TeacherGroup> groups,
}) {
  return '''${isRemote ? 'Занятия онлайн есть. Свободное время для онлайн занятий\n$remoteTime' : ''}
  \n${isLocal ? 'Занятия у репетитора есть. Свободное время для онлайн занятий у репетитора\n$localTime' : ''}
  \n${isDeparture ? 'Занятия у ученика есть. Свободное время для онлайн занятий у ученика\n $localTime' : ''}
  Групповые анкеты\n ${groups.toList()}
''';
}

String userPromptAction(
    {required List<String> actions,
    required String about,
    required String prices}) {
  return '''
Акции:\n
$actions\n
Поле "О себе":\n
$about
Цены занятий
''';
}
