import 'package:tutor_letter_gen/models/criteria.dart';
import 'package:tutor_letter_gen/models/issue.dart';

class LetterEvent {}

class AddInLetter extends LetterEvent {
  final Criteria criteria;

  AddInLetter({required this.criteria});
}

class DeleteFromLetter extends LetterEvent {
  final Criteria criteria;

  DeleteFromLetter({required this.criteria});
}

class SetDecoration extends LetterEvent {
  final int decoration;

  SetDecoration({required this.decoration});
}

class FetchSettings extends LetterEvent {}

class CleanLetter extends LetterEvent {}

class AddinLetterFromIssues extends LetterEvent {
  final List<Issue> issues;
  final List<Criteria> errors;
  final List<Criteria> recommendations;

  AddinLetterFromIssues(
      {required this.errors,
      required this.recommendations,
      required this.issues});
}
