// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'dart:convert';

import '/models/teacher/teacher_item.dart';

class TeacherAdvance extends TeacherItem {
  final String text;

  TeacherAdvance({
    required super.value,
    required this.text,
    required super.file,
  });

  TeacherAdvance copyWith({
    String? value,
    String? text,
    String? file,
  }) {
    return TeacherAdvance(
      value: value ?? this.value,
      text: text ?? this.text,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'text': text,
      'file': file,
    };
  }

  factory TeacherAdvance.fromMap(Map<String, dynamic> map) {
    return TeacherAdvance(
      value: map['value'] ?? '',
      text: map['text'] ?? '',
      file: map['file']?['small'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherAdvance.fromJson(String source) =>
      TeacherAdvance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Достижения( Текст: $value, Скан документа: $file)';

  @override
  bool operator ==(covariant TeacherAdvance other) {
    if (identical(this, other)) return true;

    return other.value == value && other.text == text && other.file == file;
  }

  @override
  int get hashCode => value.hashCode ^ text.hashCode ^ file.hashCode;
}
