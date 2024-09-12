import 'package:tutor_letter_gen/models/email_answer.dart';

class EmailLetterEvent {}

class AddInEmailLetter extends EmailLetterEvent {
  final EmailAnswer answer;

  AddInEmailLetter({required this.answer});
}

class DeleteFromEmailLetter extends EmailLetterEvent {
  final EmailAnswer answer;

  DeleteFromEmailLetter({required this.answer});
}

class SetDecoration extends EmailLetterEvent {
  final int decoration;

  SetDecoration({required this.decoration});
}

class EmailFetchSettings extends EmailLetterEvent {}

class CleanEmailLetter extends EmailLetterEvent {}
