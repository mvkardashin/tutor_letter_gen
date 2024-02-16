// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tutor_letter_gen/models/criteria.dart';

class Criterias {
  List<Criteria> errors;
  List<Criteria> recs;
  Criterias({
    required this.errors,
    required this.recs,
  });

  Criterias.empty({
    this.errors = const [],
    this.recs = const [],
  });

  Criterias copyWith({
    List<Criteria>? errors,
    List<Criteria>? recs,
  }) {
    return Criterias(
      errors: errors ?? this.errors,
      recs: recs ?? this.recs,
    );
  }
}
