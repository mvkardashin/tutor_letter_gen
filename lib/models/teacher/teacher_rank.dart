// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'dart:convert';

import '/models/teacher/teacher_item.dart';

class TeacherRank extends TeacherItem {
  final String text;

  TeacherRank({
    required super.file,
    required this.text,
    required super.value,
  });

  TeacherRank copyWith({
    String? file,
    String? text,
    String? value,
  }) {
    return TeacherRank(
      file: file ?? this.file,
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': file,
      'text': text,
      'value': value,
    };
  }

  factory TeacherRank.fromMap(Map<String, dynamic> map) {
    return TeacherRank(
      file: map['file']?['small'] ?? '',
      text: map['text'] ?? '',
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherRank.fromJson(String source) =>
      TeacherRank.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Научное звание(Звание: $value, Кафедра: $text, Скан документа: $file )';

  @override
  bool operator ==(covariant TeacherRank other) {
    if (identical(this, other)) return true;

    return other.file == file && other.text == text && other.value == value;
  }

  @override
  int get hashCode => file.hashCode ^ text.hashCode ^ value.hashCode;
}
