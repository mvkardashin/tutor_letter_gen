import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/email_letter/email_letter_event.dart';

import 'package:tutor_letter_gen/models/email_answer.dart';

import 'email_letter_state.dart';

class EmailLetterBloc extends Bloc<EmailLetterEvent, EmailLetterState> {
  EmailLetterBloc() : super(EmailLetterState.init()) {
    on<AddInEmailLetter>(_onAddInLetter);
    on<DeleteFromEmailLetter>(_onDeleteFromLetter);
    on<CleanEmailLetter>(_onCleanLetter);
    // on<SetDecoration>(_onSetDecoration);
    // on<FetchSettings>(_onFetchSettings);
  }

  FutureOr<void> _onAddInLetter(
      AddInEmailLetter event, Emitter<EmailLetterState> emit) {
    List<EmailAnswer> answers = List.from(state.answers);
    answers.add(event.answer);
    emit(state.copyWith(answers: answers));
  }

  FutureOr<void> _onDeleteFromLetter(
      DeleteFromEmailLetter event, Emitter<EmailLetterState> emit) {
    List<EmailAnswer> answers = List.from(state.answers);

    answers.remove(event.answer);
    emit(state.copyWith(answers: answers));
  }

  FutureOr<void> _onCleanLetter(
      CleanEmailLetter event, Emitter<EmailLetterState> emit) {
    emit(EmailLetterState.init());
  }

  // FutureOr<void> _onSetDecoration(
  //     SetDecoration event, Emitter<LetterState> emit) {
  //   emit(state.copyWith(decoration: event.decoration));
  //   SP.setDecoration(event.decoration);
  // }

  // FutureOr<void> _onFetchSettings(
  //     FetchSettings event, Emitter<LetterState> emit) async {
  //   int decorationValue = await SP.getDecoration();
  //   emit(state.copyWith(decoration: decorationValue));
  // }
}
