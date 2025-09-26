import 'package:tutor_letter_gen/models/teacher/teacher.dart';

class IssuesEvent {}

class FetchIssues extends IssuesEvent {
  final Teacher teacher;
  FetchIssues({required this.teacher});
}

class LoadIssues extends IssuesEvent {}
