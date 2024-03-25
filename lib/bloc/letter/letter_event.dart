import 'package:tutor_letter_gen/models/criteria.dart';

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
