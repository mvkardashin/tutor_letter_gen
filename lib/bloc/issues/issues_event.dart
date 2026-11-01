// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tutor_letter_gen/models/teacher/teacher.dart';

class IssuesEvent {}

class FetchIssues extends IssuesEvent {
  final Teacher teacher;

  FetchIssues({
    required this.teacher,
  });
}

class FetchPersonalBatchIssue extends IssuesEvent {
  final Teacher teacher;

  FetchPersonalBatchIssue({
    required this.teacher,
  });
}

class FetchBadBatchIssue extends IssuesEvent {
  final Teacher teacher;

  FetchBadBatchIssue({
    required this.teacher,
  });
}

class FetchGroupBatchIssue extends IssuesEvent {
  final Teacher teacher;

  FetchGroupBatchIssue({
    required this.teacher,
  });
}

class FetchTimeBatchIssue extends IssuesEvent {
  final Teacher teacher;
  FetchTimeBatchIssue({required this.teacher});
}

class FetchNativeBatchIssue extends IssuesEvent {
  final Teacher teacher;
  FetchNativeBatchIssue({required this.teacher});
}

class FetchActionBatchIssue extends IssuesEvent {
  final Teacher teacher;
  FetchActionBatchIssue({required this.teacher});
}

class LoadIssues extends IssuesEvent {}
