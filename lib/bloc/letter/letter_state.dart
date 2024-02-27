// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tutor_letter_gen/models/criteria.dart';

class LetterState {
  final String greetings;
  final String acceptTeacher;
  final String deniedTeacher;
  final String errorsHeadline;
  final String recsHeadline;
  final List<Criteria> errors;
  final List<Criteria> recommendation;

  LetterState({
    required this.greetings,
    required this.acceptTeacher,
    required this.deniedTeacher,
    required this.errorsHeadline,
    required this.recsHeadline,
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
    return '<ul>$errorsText</ul>';
  }

  String get recsHtml {
    String recsText = '';
    for (Criteria e in recommendation) {
      recsText = recsText + e.htmlLi;
    }
    return '<ul>$recsText</ul>';
  }

  String get greetingsHtml => '<div>$greetings</div>';
  String get acceptTeacherHtml => '<div>$acceptTeacher</div>';
  String get deniedTeacherHtml => '<div>$deniedTeacher</div>';
  String get errorsHeadlineHtml => '<h2>$errorsHeadline</h2>';
  String get recsHeadlineHtml => '<h2>$recsHeadline</h2>';

  String get toText =>
      greetings +
      (errors.isEmpty ? acceptTeacher : deniedTeacher) +
      (errors.isEmpty ? '' : errorsHeadline) +
      errorsText +
      (recommendation.isEmpty ? '' : recsHeadline) +
      recsText;

  String get toHtml =>
      '<html><body>'+greetingsHtml +
      (errors.isEmpty ? acceptTeacherHtml : deniedTeacherHtml) +
      (errors.isEmpty ? '' : errorsHeadlineHtml) +
      errorsHtml +
      (recommendation.isEmpty ? '' : recsHeadlineHtml) +
      recsHtml+'</body></html>';

  LetterState copyWith({
    String? greetings,
    String? acceptTeacher,
    String? deniedTeacher,
    String? errorsHeadline,
    String? recsHeadline,
    List<Criteria>? errors,
    List<Criteria>? recommendation,
  }) {
    return LetterState(
        greetings: greetings ?? this.greetings,
        acceptTeacher: acceptTeacher ?? this.acceptTeacher,
        deniedTeacher: deniedTeacher ?? this.deniedTeacher,
        errors: errors ?? this.errors,
        recommendation: recommendation ?? this.recommendation,
        errorsHeadline: errorsHeadline ?? this.errorsHeadline,
        recsHeadline: recsHeadline ?? this.recsHeadline);
  }
}
