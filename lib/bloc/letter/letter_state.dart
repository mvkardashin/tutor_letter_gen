// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tutor_letter_gen/models/criteria.dart';

class LetterState {
  final String greetings;
  final String acceptTeacher;
  final String deniedTeacher;
  final String errorsHeadline;
  final String recsHeadline;
  final String endText;
  final String withRespect;
  // final List<String> codes;
  final List<Criteria> errors;
  final List<Criteria> recommendation;

  const LetterState({
    required this.greetings,
    required this.acceptTeacher,
    required this.deniedTeacher,
    required this.errorsHeadline,
    required this.recsHeadline,
    required this.endText,
    required this.withRespect,
    // required this.codes,
    required this.errors,
    required this.recommendation,
  });

  const LetterState.init()
      : greetings = 'Здравствуйте!',
        acceptTeacher = 'Ваша анкета опубликована.',
        deniedTeacher =
            'Ваша анкета возвращена на доработку. Для допуска нужно исправить:',
        errorsHeadline = 'Причины возврата',
        recsHeadline = 'Рекомендации',
        endText =
            'Пожалуйста, не забудьте, после внесения изменений, отправить анкету на проверку.',
        withRespect = 'С уважением, администратор Сервиса.',
        // codes = const <String>[],
        errors = const <Criteria>[],
        recommendation = const <Criteria>[];

  String _buildListText(List<Criteria> items) {
    return items.map((e) => e.value).join();
  }

  String _buildHtmlList(List<Criteria> items) {
    final sortedItems = List<Criteria>.from(items)
      ..sort((a, b) => a.id.compareTo(b.id));
    final listItems = sortedItems.map((e) => e.card).join();
    return listItems;
  }

  String get errorsText => _buildListText(errors);
  String get recsText => _buildListText(recommendation);
  String get errorsHtml => _buildHtmlList(errors);
  String get recsHtml => _buildHtmlList(recommendation);

  String _wrapHtml(String text, String tag, {String? style}) {
    final styleAttr = style != null ? ' style="$style"' : '';
    return '<$tag$styleAttr>$text</$tag>';
  }

  String get greetingsHtml => _wrapHtml(greetings, 'div');
  String get acceptTeacherHtml => """<div style="padding:16px;">
<h2 style="margin:0; font-size:18px; color:black;">✅ Ваша анкета опубликована</h2>
</div>""";
  String get deniedTeacherHtml => """<div style="padding:16px;">
<h2 style="margin:0; font-size:18px; color:black;">⚠️ Ваша анкета возвращена на доработку</h2>
</div>""";
  String get errorsHeadlineHtml =>
      _wrapHtml(errorsHeadline, 'h2', style: 'padding-left:0px');
  String get recsHeadlineHtml =>
      _wrapHtml(recsHeadline, 'h2', style: 'padding-left:0px');
  String get endTextHtml => _wrapHtml(endText, 'p');
  String get withRespectHtml => _wrapHtml(withRespect, 'p');

  String get toText {
    final hasErrors = errors.isNotEmpty;
    final hasRecs = recommendation.isNotEmpty;

    return [
      greetings,
      hasErrors ? deniedTeacher : acceptTeacher,
      if (hasErrors) errorsHeadline,
      errorsText,
      if (hasRecs) recsHeadline,
      recsText,
      if (hasErrors) endText,
      withRespect,
    ].join();
  }

  String get toHtml {
    final hasErrors = errors.isNotEmpty;
    final hasRecs = recommendation.isNotEmpty;

    final content = [
      greetingsHtml,
      hasErrors ? deniedTeacherHtml : acceptTeacherHtml,
      if (hasErrors) errorsHeadlineHtml,
      errorsHtml,
      if (hasRecs) recsHeadlineHtml,
      recsHtml,
      if (hasErrors) endTextHtml,
      if (!hasErrors) withRespectHtml,
    ].join();

    return "<html><body ><div style='background-color:white;padding:20px'>$content</div></body></html>";
  }

  LetterState copyWith({
    List<Criteria>? errors,
    List<Criteria>? recommendation,
  }) {
    return LetterState(
      greetings: greetings,
      acceptTeacher: acceptTeacher,
      deniedTeacher: deniedTeacher,
      errors: errors ?? this.errors,
      withRespect: withRespect,
      endText: endText,
      recommendation: recommendation ?? this.recommendation,
      errorsHeadline: errorsHeadline,
      recsHeadline: recsHeadline,
    );
  }
}
