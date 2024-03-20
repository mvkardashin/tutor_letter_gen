import 'package:tutor_letter_gen/models/criteria.dart';

class LetterState {
  final String greetings;
  final String acceptTeacher;
  final String deniedTeacher;
  final String errorsHeadline;
  final String recsHeadline;
  final String endText;
  final List<Criteria> errors;
  final List<Criteria> recommendation;

  LetterState({
    required this.greetings,
    required this.acceptTeacher,
    required this.deniedTeacher,
    required this.errorsHeadline,
    required this.recsHeadline,
    required this.endText,
    required this.errors,
    required this.recommendation,
  });

  LetterState.init(
      {this.greetings = 'Здравствуйте!',
      this.acceptTeacher = 'Ваша анкета опубликована.',
      this.deniedTeacher =
          'Ваша анкета возвращена на доработку. Для допуска нужно исправить:',
      this.errorsHeadline = 'Причины возврата',
      this.recsHeadline = 'Рекомендации',
      this.endText = 'Рекомендации',
      this.errors = const <Criteria>[],
      this.recommendation = const <Criteria>[]});

  String get errorsText {
    String errorsText = '';
    for (Criteria e in errors) {
      errorsText = errorsText + e.value;
    }
    return errorsText;
  }

  String get recsText {
    String recsText = '';
    for (Criteria e in recommendation) {
      recsText = recsText + e.value;
    }
    return recsText;
  }

  String get errorsHtml {
    String errorsText = '';
    for (Criteria e in errors) {
      errorsText = errorsText + e.htmlLi;
    }
    return "<ul>$errorsText</ul>";
  }

  String get recsHtml {
    String recsText = '';
    for (Criteria e in recommendation) {
      recsText = recsText + e.htmlLi;
    }
    return "<ul>$recsText</ul>";
  }

  String get greetingsHtml => '<div>$greetings</div>';
  String get acceptTeacherHtml => '<div>$acceptTeacher</div>';
  String get deniedTeacherHtml => '<div>$deniedTeacher</div>';
  String get errorsHeadlineHtml =>
      '<h2 style="padding-left:20px">$errorsHeadline</h2>';
  String get recsHeadlineHtml =>
      '<h2 style="padding-left:20px">$recsHeadline</h2>';
  String get endTextHtml =>
      '<p>Пожалуйста, не забудьте, после внесения изменений, отправить анкету на проверку.</p>';
  String get toText =>
      (errors.isEmpty ? '' : greetings) +
      (errors.isEmpty ? acceptTeacher : deniedTeacher) +
      (errors.isEmpty ? '' : errorsHeadline) +
      errorsText +
      (recommendation.isEmpty ? '' : recsHeadline) +
      recsText +
      (errors.isEmpty ? '' : endText);

  String get toHtml =>
      '<html><body>' +
      (errors.isEmpty ? '' : greetingsHtml) +
      (errors.isEmpty ? acceptTeacherHtml : deniedTeacherHtml) +
      (errors.isEmpty ? '' : errorsHeadlineHtml) +
      errorsHtml +
      (recommendation.isEmpty ? '' : recsHeadlineHtml) +
      recsHtml +
      (errors.isEmpty ? '' : endTextHtml) +
      '</body></html>';

  LetterState copyWith({
    List<Criteria>? errors,
    List<Criteria>? recommendation,
  }) {
    return LetterState(
        greetings: greetings,
        acceptTeacher: acceptTeacher,
        deniedTeacher: deniedTeacher,
        errors: errors ?? this.errors,
        endText: endText,
        recommendation: recommendation ?? this.recommendation,
        errorsHeadline: errorsHeadline,
        recsHeadline: recsHeadline);
  }
}
