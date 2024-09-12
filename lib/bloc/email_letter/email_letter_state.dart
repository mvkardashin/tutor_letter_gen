import 'package:tutor_letter_gen/models/email_answer.dart';

class EmailLetterState {
  final String greetings;

  final String withRespect;
  final List<EmailAnswer> answers;

  EmailLetterState(
      {required this.greetings,
      required this.withRespect,
      required this.answers});

  EmailLetterState.init(
      {this.greetings = 'Добрый день',
      this.withRespect = 'С уважением, администратор cервиса Repetitor.ru.',
      this.answers = const <EmailAnswer>[]});

  String get emailAnswersText {
    String emailAnswers = '';
    for (EmailAnswer e in answers) {
      emailAnswers = emailAnswers + e.value;
    }
    return emailAnswers;
  }

  String get emailAnswersHtml {
    String emailAnswers = '';
    for (EmailAnswer e in answers) {
      emailAnswers = emailAnswers + e.htmlLi;
    }
    return "<ul>$emailAnswers</ul>";
  }

  String get greetingsHtml => '<div>$greetings</div>';

  String get withRespectHtml => '<p>$withRespect</p>';
  String get toText =>
      (answers.isEmpty ? '' : greetings) + emailAnswersText + withRespect;

  String get toHtml =>
      '<html><body>$greetings$emailAnswersHtml$withRespectHtml</body></html>';

  EmailLetterState copyWith({
    List<EmailAnswer>? answers,
  }) {
    return EmailLetterState(
      greetings: greetings,
      answers: answers ?? this.answers,
      withRespect: withRespect,
    );
  }
}
