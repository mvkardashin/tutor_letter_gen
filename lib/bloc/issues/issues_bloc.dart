import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/criterias/criterias_bloc_repository.dart';
import 'package:tutor_letter_gen/models/criteria.dart';
import 'package:tutor_letter_gen/services/constants.dart';
import 'package:tutor_letter_gen/services/promt_generator.dart';

import '/bloc/issues/issues_event.dart';
import '/bloc/issues/issues_repository.dart';
import '/bloc/issues/issues_state.dart';

class TutorIssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  TutorIssuesBloc(
      {required this.issuesRepository, required this.criteriasRepository})
      : super(IssuesState(
            issues: [],
            personalBatchIssues: [],
            nativeIssues: [],
            badIssues: [],
            priceIssues: [],
            timeIssues: [],
            aboutIssues: [],
            groupIssues: [],
            educationAndOtherIssues: [],
            noneIssues: [],
            actionIssues: [])) {
    on<FetchIssues>(_onFetchIssues);

    on<LoadIssues>(_onLoadIssues);
    on<FetchPersonalBatchIssue>(_onFetchPersonalBatchIssue);
    on<FetchNativeBatchIssue>(_onFetchNativeBatchIssue);
    on<FetchBadBatchIssue>(_onFetchBadBatchIssue);
    on<FetchGroupBatchIssue>(_onFetchGroupBatchIssue);
    on<FetchTimeBatchIssue>(_onFetchTimeBatchIssue);
    on<FetchTimeBatchIssue>(_onFetchTimeBatchIssue);
    on<FetchActionBatchIssue>(_onFetchActionBatchIssue);
  }
  final IssuesRepository issuesRepository;
  final CriteriasRepository criteriasRepository;

  FutureOr<void> _onFetchIssues(
      FetchIssues event, Emitter<IssuesState> emit) async {
    final allIssues = await issuesRepository.fetchAllIssues(
        teacher: event.teacher, aiErrors: criteriasRepository.aiErrors);
    emit(state.copyWith(issues: allIssues));
  }

  FutureOr<void> _onLoadIssues(LoadIssues event, Emitter<IssuesState> emit) {}

  FutureOr<void> _onFetchPersonalBatchIssue(
      FetchPersonalBatchIssue event, Emitter<IssuesState> emit) async {
    List<Criteria> personalBatchCriterias =
        criteriasRepository.personalBatchCriterias;
    String errors = personalBatchCriterias.map((el) => el.error).join('\n');
    debugPrint(generatePersonalPrompt(errors));
    debugPrint(event.teacher.userFullname);
    debugPrint((generatePersonalPrompt(errors).length +
            event.teacher.userFullname.length)
        .toString());
  }

  FutureOr<void> _onFetchBadBatchIssue(
      FetchBadBatchIssue event, Emitter<IssuesState> emit) async {
    List<Criteria> badBatchCriterias = criteriasRepository.badBatchCriterias;
    String errors = badBatchCriterias.map((el) => el.error).join('\n');
    debugPrint(generatePersonalPrompt(errors));
    debugPrint(event.teacher.text);
    debugPrint(
        (generatePersonalPrompt(errors).length + event.teacher.text.length)
            .toString());
  }

  FutureOr<void> _onFetchGroupBatchIssue(
      FetchGroupBatchIssue event, Emitter<IssuesState> emit) async {
    if (event.teacher.groups.isEmpty) {
      debugPrint('isEmpty');
    } else {
      List<Criteria> groupBatchCriterias =
          criteriasRepository.groupBatchCriterias;
      String errors = groupBatchCriterias.map((el) => el.error).join('\n');
      debugPrint(generatePersonalPrompt(errors));
      debugPrint(event.teacher.text +
          event.teacher.groups.toString() +
          event.teacher.timeDepartureFormatted +
          event.teacher.timeLocalFormatted +
          event.teacher.timeOnlineFormatted);
      debugPrint((generatePersonalPrompt(errors).length +
              (event.teacher.text +
                      event.teacher.groups.toString() +
                      event.teacher.timeDepartureFormatted +
                      event.teacher.timeLocalFormatted +
                      event.teacher.timeOnlineFormatted)
                  .length)
          .toString());
    }
  }

  FutureOr<void> _onFetchNativeBatchIssue(
      FetchNativeBatchIssue event, Emitter<IssuesState> emit) {
    if (nativeCategories.any((el) => event.teacher.categories.contains(el))) {
      List<Criteria> nativeCriterias = criteriasRepository.groupBatchCriterias;
      String errors = nativeCriterias.map((el) => el.error).join('\n');
      debugPrint(generatePersonalPrompt(errors));
      debugPrint(event.teacher.text);
    } else {
      debugPrint('nothing');
    }
  }

  FutureOr<void> _onFetchTimeBatchIssue(
      FetchTimeBatchIssue event, Emitter<IssuesState> emit) {
    List<Criteria> criterias = criteriasRepository.timeBatchCriterias;
    String errors = criterias.map((el) => el.error).join('\n');
    debugPrint(generatePersonalPrompt(errors));
    debugPrint(userPromptTime(
        isRemote: event.teacher.remoteLessons.isNotEmpty,
        isDeparture: event.teacher.departureLessons.isNotEmpty,
        isLocal: event.teacher.localLessons.isNotEmpty,
        remoteTime: event.teacher.timeOnlineFormatted,
        localTime: event.teacher.timeLocalFormatted,
        departureTime: event.teacher.timeDepartureFormatted,
        groups: event.teacher.groups));
  }

  FutureOr<void> _onFetchActionBatchIssue(
      FetchActionBatchIssue event, Emitter<IssuesState> emit) {
    List<Criteria> criterias = criteriasRepository.actionBatchCriterias;
    String errors = criterias.map((el) => el.error).join('\n');
    debugPrint(generatePersonalPrompt(errors));
    debugPrint(userPromptAction(
        actions: event.teacher.actions,
        about: event.teacher.text,
        prices: event.teacher.lessonPricesOnly));
  }
}
