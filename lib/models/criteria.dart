// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tutor_letter_gen/models/criteria_type.dart';

class Criteria {
  final CriteriaType type;
  final String reason;
  final String desc;
  final String value;
  final String html;
  final int id;
  Criteria({
    required this.type,
    required this.reason,
    required this.desc,
    required this.value,
    required this.html,
    required this.id,
  });

  Criteria copyWith(
      {CriteriaType? type,
      String? reason,
      String? desc,
      String? value,
      String? html,
      int? id}) {
    return Criteria(
        type: type ?? this.type,
        reason: reason ?? this.reason,
        desc: desc ?? this.desc,
        value: value ?? this.value,
        html: html ?? this.html,
        id: id ?? this.id);
  }

  String get htmlLi => "<li>$html</li>";
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.toString(),
      'reason': reason,
      'desc': desc,
      'value': value,
      'html': html,
      'id': id
    };
  }

  factory Criteria.error(Map<dynamic, dynamic> map) {
    return Criteria(
      type: CriteriaType.error,
      reason: map['reason'] as String,
      desc: map['desc'] as String,
      value: map['value'] as String,
      html: map['html'] as String,
      id: map['id'] as int,
    );
  }

  factory Criteria.rec(Map<dynamic, dynamic> map) {
    return Criteria(
      type: CriteriaType.recommendation,
      reason: map['reason'] as String,
      desc: map['desc'] as String,
      value: map['value'] as String,
      html: map['html'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Criteria.errorfromJson(String source) =>
      Criteria.error(json.decode(source) as Map<String, dynamic>);
  factory Criteria.recfromJson(String source) =>
      Criteria.rec(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return 'Criteria(type: $type, reason: $reason, desc: $desc, value: $value,html: $html,id: $id)';
  }

  @override
  bool operator ==(covariant Criteria other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.reason == reason &&
        other.desc == desc &&
        other.value == value &&
        other.html == html &&
        other.id == id;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        reason.hashCode ^
        desc.hashCode ^
        value.hashCode ^
        html.hashCode ^
        id.hashCode;
  }
}
