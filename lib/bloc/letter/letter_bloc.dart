import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/criterias/criterias_bloc_repository.dart';
import 'package:tutor_letter_gen/bloc/issues/issues_repository.dart';
import 'package:tutor_letter_gen/models/criteria.dart';

import '/bloc/letter/letter_event.dart';
import '/bloc/letter/letter_state.dart';

import '../../models/criteria_type.dart';

class LetterBloc extends Bloc<LetterEvent, LetterState> {
  LetterBloc(
      {required this.criteriasRepository, required this.issuesRepository})
      : super(LetterState.init()) {
    on<AddInLetter>(_onAddInLetter);
    on<DeleteFromLetter>(_onDeleteFromLetter);
    on<CleanLetter>(_onCleanLetter);
    on<AddinLetterFromIssues>(_onAddinLetterFromIssues);
  }

  final CriteriasRepository criteriasRepository;
  final IssuesRepository issuesRepository;

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
    List<String> issues = issuesRepository.issues;
    debugPrint(issues.toString());
    List<Criteria> issuedCriterias =
        criteriasRepository.criteriasForIssues(issues);
    debugPrint(issuedCriterias.toString());
    List<Criteria> errors = issuedCriterias
        .where((element) => element.type == CriteriaType.error)
        .toList();
    List<Criteria> recs = issuedCriterias
        .where((element) => element.type == CriteriaType.recommendation)
        .toList();
    emit(state.copyWith(
      errors: errors,
      recommendation: recs,
    ));
  }
}
