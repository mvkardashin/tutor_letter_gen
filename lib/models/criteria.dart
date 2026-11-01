// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '/models/criteria_type.dart';

enum CheckType { ai, none, localcheck }

enum Batch {
  personal,
  native,
  bad,
  price,
  time,
  about,
  group,
  educationAndOther,
  none,
  action
}

class Criteria {
  final CriteriaType type;
  final String reason;
  final String desc;
  final String value;
  final String html;
  final int id;
  final CheckType checkType;
  final String code;
  final String prompt;
  final Batch batch;

  Criteria({
    required this.type,
    required this.reason,
    required this.desc,
    required this.value,
    required this.html,
    required this.id,
    required this.checkType,
    required this.code,
    required this.prompt,
    required this.batch,
  });

  Criteria copyWith({
    CriteriaType? type,
    String? reason,
    String? desc,
    String? value,
    String? html,
    int? id,
    CheckType? checkType,
    String? code,
    String? prompt,
    Batch? batch,
  }) {
    return Criteria(
        type: type ?? this.type,
        reason: reason ?? this.reason,
        desc: desc ?? this.desc,
        value: value ?? this.value,
        html: html ?? this.html,
        id: id ?? this.id,
        checkType: checkType ?? this.checkType,
        code: code ?? this.code,
        prompt: prompt ?? this.prompt,
        batch: batch ?? this.batch);
  }

  String get error => '{prompt: $prompt, code: $code}';

  String get htmlLi => "<li>$html</li>";

  String get card =>
      """<div style="width:100%; margin:20px auto; font-family:Arial, sans-serif; color:#333;">
<div style="
border:1px solid #e0e0e0;
border-radius:8px;
padding:16px;
background:#ffffff;
box-shadow: 0 2px 6px rgba(0,0,0,0.05);
">


<h3 style="margin:0 0 12px 0; font-size:16px; color:black">
 ${type == CriteriaType.error ? '✏️ Нужно исправить' : '✅ Рекомендация'} 
</h3>
      $html
</div>
</div>
  """;

  @override
  String toString() {
    return 'Criteria(type: $type, reason: $reason, desc: $desc, value: $value, html: $html, id: $id, checkType: $checkType, code: $code, prompt: $prompt, batch: $batch)';
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

  Map<String, dynamic> toMap() {
    return {
      'type': type.name, // enum → string
      'reason': reason,
      'desc': desc,
      'value': value,
      'html': html,
      'id': id,
      'checktype': checkType.name,
      'code': code,
      'prompt': prompt,
      'batch': batch.name,
    };
  }

  factory Criteria.fromMap(Map<String, dynamic> map) {
    return Criteria(
      type: _criteriaTypeFromString(map['type']),
      reason: map['reason'] ?? '',
      desc: map['desc'] ?? '',
      value: map['value'] ?? '',
      html: map['html'] ?? '',
      id: (map['id'] is int)
          ? map['id']
          : int.tryParse(map['id'].toString()) ?? 0,
      checkType: _checkTypeFromString(map['checktype']),
      code: map['code'] ?? '',
      prompt: map['prompt'] ?? '',
      batch: _checkBatchFromString(map['batch']),
    );
  }

  factory Criteria.fromJson(String source) =>
      Criteria.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  static CriteriaType _criteriaTypeFromString(String? str) {
    switch (str?.toLowerCase()) {
      case 'error':
        return CriteriaType.error;
      case 'recommendation':
        return CriteriaType.recommendation;
      default:
        return CriteriaType.error;
    }
  }

  static CheckType _checkTypeFromString(String? str) {
    switch (str?.toLowerCase()) {
      case 'ai':
        return CheckType.ai;
      case 'none':
        return CheckType.none;
      case 'localcheck':
        return CheckType.localcheck;
      default:
        return CheckType.none;
    }
  }

  static Batch _checkBatchFromString(String? str) {
    switch (str?.toLowerCase()) {
      case 'education and other':
        return Batch.educationAndOther;
      case 'price':
        return Batch.price;
      case 'personal':
        return Batch.personal;
      case 'time':
        return Batch.time;
      case 'about':
        return Batch.about;
      case 'group':
        return Batch.group;
      case 'native':
        return Batch.native;
      case 'bad':
        return Batch.bad;
      case 'action':
        return Batch.action;
      default:
        return Batch.none;
    }
  }
}
