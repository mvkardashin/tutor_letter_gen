// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tutor_letter_gen/models/criteria.dart';

import '/models/status.dart';

class CriteriasState {
  final Status status;
  final bool canUpdate;
  final String fetchedCriterias;
  final List<Criteria> criterias;
  final List<Criteria> filteredCriterias;

  CriteriasState(
      {required this.status,
      required this.canUpdate,
      required this.fetchedCriterias,
      required this.criterias,
      required this.filteredCriterias});

  CriteriasState copyWith({
    Status? status,
    List<Criteria>? criterias,
    List<Criteria>? filteredCriterias,
    bool? canUpdate,
    String? fetchedCriterias,
  }) {
    return CriteriasState(
        status: status ?? this.status,
        criterias: criterias ?? this.criterias,
        canUpdate: canUpdate ?? this.canUpdate,
        fetchedCriterias: fetchedCriterias ?? this.fetchedCriterias,
        filteredCriterias: filteredCriterias ?? this.filteredCriterias);
  }

  @override
  String toString() => 'CriteriasState(status: $status, criterias: $criterias)';

  @override
  int get hashCode {
    return status.hashCode ^
        canUpdate.hashCode ^
        fetchedCriterias.hashCode ^
        criterias.hashCode ^
        filteredCriterias.hashCode;
  }

  @override
  bool operator ==(covariant CriteriasState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.canUpdate == canUpdate &&
        other.fetchedCriterias == fetchedCriterias &&
        other.criterias == criterias &&
        other.filteredCriterias == filteredCriterias;
  }

  String get aiErrors => criterias
      .where((cr) => cr.checkType == CheckType.ai)
      .map((e) => '{prompt: ${e.prompt}, code: ${e.code}}')
      .join('\n');

  List<Criteria> criteriasForIssues(List<String> issues) {
    return criterias.where((c) => issues.contains(c.code)).toList();
  }
}
