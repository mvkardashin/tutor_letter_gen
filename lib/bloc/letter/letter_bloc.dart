import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/models/criteria.dart';
import 'package:tutor_letter_gen/models/issue.dart';
import 'package:collection/collection.dart';
import '/bloc/letter/letter_event.dart';
import '/bloc/letter/letter_state.dart';

import '../../models/criteria_type.dart';

class LetterBloc extends Bloc<LetterEvent, LetterState> {
  LetterBloc() : super(LetterState.init()) {
    on<AddInLetter>(_onAddInLetter);
    on<DeleteFromLetter>(_onDeleteFromLetter);
    on<CleanLetter>(_onCleanLetter);
    on<AddinLetterFromIssues>(_onAddinLetterFromIssues);
    // on<SetDecoration>(_onSetDecoration);
    // on<FetchSettings>(_onFetchSettings);
  }

  FutureOr<void> _onAddInLetter(AddInLetter event, Emitter<LetterState> emit) {
    if (event.criteria.type == CriteriaType.error) {
      List<Criteria> errors = List.from(state.errors);
      errors.add(event.criteria);
      emit(state.copyWith(errors: errors));
    } else {
      List<Criteria> recs = List.from(state.recommendation);
      recs.add(event.criteria);
      emit(state.copyWith(recommendation: recs));
    }
  }

  FutureOr<void> _onDeleteFromLetter(
      DeleteFromLetter event, Emitter<LetterState> emit) {
    if (event.criteria.type == CriteriaType.error) {
      List<Criteria> errors = List.from(state.errors);
      errors.remove(event.criteria);
      emit(state.copyWith(errors: errors));
    } else {
      List<Criteria> recs = List.from(state.recommendation);
      recs.remove(event.criteria);
      emit(state.copyWith(recommendation: recs));
    }
  }

  FutureOr<void> _onCleanLetter(CleanLetter event, Emitter<LetterState> emit) {
    emit(LetterState.init());
  }

  FutureOr<void> _onAddinLetterFromIssues(
      AddinLetterFromIssues event, Emitter<LetterState> emit) {
    for (Issue issue in event.issues) {
      if (issue.isWarning) {
        Criteria? error = event.errors
            .firstWhereOrNull((element) => element.id == issue.excelId);
        if (error != null) {
          List<Criteria> errors = List.from(state.errors);
          errors.add(error);
          emit(state.copyWith(errors: errors));
        }
      } else {
        Criteria? rec = event.recommendations
            .firstWhereOrNull((element) => element.id == issue.excelId);
        if (rec != null) {
          List<Criteria> recs = List.from(state.recommendation);
          recs.add(rec);
          emit(state.copyWith(errors: recs));
        }
      }
    }
  }
}
