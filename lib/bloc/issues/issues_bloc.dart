import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/issues/issues_event.dart';
import 'package:tutor_letter_gen/bloc/issues/issues_repository.dart';
import 'package:tutor_letter_gen/bloc/issues/issues_state.dart';

class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  IssuesBloc({required this.issuesRepository})
      : super(IssuesState(issues: [])) {
    on<FetchIssues>(_onFetchIssues);

    on<LoadIssues>(_onLoadIssues);
  }
  final IssuesRepository issuesRepository;

  FutureOr<void> _onFetchIssues(
      FetchIssues event, Emitter<IssuesState> emit) async {
    final allIssues =
        await issuesRepository.fetchAllIssues(teacher: event.teacher);
    emit(IssuesState(issues: allIssues));
  }

  FutureOr<void> _onLoadIssues(LoadIssues event, Emitter<IssuesState> emit) {}
}
