import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tutor_letter_gen/models/teacher/teacher.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class IssuesState {
  final Teacher? teacher;
  final List<String> issues;
  final List<String> personalBatchIssues;
  final List<String> nativeIssues;
  final List<String> badIssues;
  final List<String> priceIssues;
  final List<String> timeIssues;
  final List<String> aboutIssues;
  final List<String> groupIssues;
  final List<String> educationAndOtherIssues;
  final List<String> noneIssues;
  final List<String> actionIssues;
  IssuesState({
    this.teacher,
    required this.issues,
    required this.personalBatchIssues,
    required this.nativeIssues,
    required this.badIssues,
    required this.priceIssues,
    required this.timeIssues,
    required this.aboutIssues,
    required this.groupIssues,
    required this.educationAndOtherIssues,
    required this.noneIssues,
    required this.actionIssues,
  });

  IssuesState copyWith({
    Teacher? teacher,
    List<String>? issues,
    List<String>? personalBatchIssues,
    List<String>? nativeIssues,
    List<String>? badIssues,
    List<String>? priceIssues,
    List<String>? timeIssues,
    List<String>? aboutIssues,
    List<String>? groupIssues,
    List<String>? educationAndOtherIssues,
    List<String>? noneIssues,
    List<String>? actionIssues,
  }) {
    return IssuesState(
      teacher: teacher ?? this.teacher,
      issues: issues ?? this.issues,
      personalBatchIssues: personalBatchIssues ?? this.personalBatchIssues,
      nativeIssues: nativeIssues ?? this.nativeIssues,
      badIssues: badIssues ?? this.badIssues,
      priceIssues: priceIssues ?? this.priceIssues,
      timeIssues: timeIssues ?? this.timeIssues,
      aboutIssues: aboutIssues ?? this.aboutIssues,
      groupIssues: groupIssues ?? this.groupIssues,
      educationAndOtherIssues:
          educationAndOtherIssues ?? this.educationAndOtherIssues,
      noneIssues: noneIssues ?? this.noneIssues,
      actionIssues: actionIssues ?? this.actionIssues,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'issues': issues,
      'personalBatchIssues': personalBatchIssues,
      'nativeIssues': nativeIssues,
      'badIssues': badIssues,
      'priceIssues': priceIssues,
      'timeIssues': timeIssues,
      'aboutIssues': aboutIssues,
      'groupIssues': groupIssues,
      'educationAndOtherIssues': educationAndOtherIssues,
      'noneIssues': noneIssues,
      'actionIssues': actionIssues,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'IssuesState(issues: $issues, personalBatchIssues: $personalBatchIssues, nativeIssues: $nativeIssues, badIssues: $badIssues, priceIssues: $priceIssues, timeIssues: $timeIssues, aboutIssues: $aboutIssues, groupIssues: $groupIssues, educationAndOtherIssues: $educationAndOtherIssues, noneIssues: $noneIssues, actionIssues: $actionIssues)';
  }

  @override
  bool operator ==(covariant IssuesState other) {
    if (identical(this, other)) return true;

    return listEquals(other.issues, issues) &&
        listEquals(other.personalBatchIssues, personalBatchIssues) &&
        listEquals(other.nativeIssues, nativeIssues) &&
        listEquals(other.badIssues, badIssues) &&
        listEquals(other.priceIssues, priceIssues) &&
        listEquals(other.timeIssues, timeIssues) &&
        listEquals(other.aboutIssues, aboutIssues) &&
        listEquals(other.groupIssues, groupIssues) &&
        listEquals(other.educationAndOtherIssues, educationAndOtherIssues) &&
        listEquals(other.noneIssues, noneIssues) &&
        listEquals(other.actionIssues, actionIssues);
  }

  @override
  int get hashCode {
    return issues.hashCode ^
        personalBatchIssues.hashCode ^
        nativeIssues.hashCode ^
        badIssues.hashCode ^
        priceIssues.hashCode ^
        timeIssues.hashCode ^
        aboutIssues.hashCode ^
        groupIssues.hashCode ^
        educationAndOtherIssues.hashCode ^
        noneIssues.hashCode ^
        actionIssues.hashCode;
  }
}
