// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmailAnswer {
  final String reason;
  final String desc;
  final String value;
  final String html;
  final int id;
  EmailAnswer({
    required this.reason,
    required this.desc,
    required this.value,
    required this.html,
    required this.id,
  });

  EmailAnswer copyWith(
      {String? reason, String? desc, String? value, String? html, int? id}) {
    return EmailAnswer(
        reason: reason ?? this.reason,
        desc: desc ?? this.desc,
        value: value ?? this.value,
        html: html ?? this.html,
        id: id ?? this.id);
  }

  String get htmlLi => "<li>$html</li>";
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reason': reason,
      'desc': desc,
      'value': value,
      'html': html,
      'id': id
    };
  }

  factory EmailAnswer.fromMap(Map<dynamic, dynamic> map) {
    return EmailAnswer(
      reason: map['reason'] as String,
      desc: map['desc'] as String,
      value: map['value'] as String,
      html: map['html'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailAnswer.fromJson(String source) =>
      EmailAnswer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmailAnswer( reason: $reason, desc: $desc, value: $value,html: $html,id: $id)';
  }

  @override
  bool operator ==(covariant EmailAnswer other) {
    if (identical(this, other)) return true;

    return other.reason == reason &&
        other.desc == desc &&
        other.value == value &&
        other.html == html &&
        other.id == id;
  }

  @override
  int get hashCode {
    return reason.hashCode ^
        desc.hashCode ^
        value.hashCode ^
        html.hashCode ^
        id.hashCode;
  }
}
