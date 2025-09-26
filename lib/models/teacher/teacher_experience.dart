// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'dart:convert';

import '/models/teacher/teacher_item.dart';

class TeacherExperience extends TeacherItem {
  final String text;

  TeacherExperience(
      {required super.value, required super.file, required this.text});

  TeacherExperience copyWith({
    String? value,
    String? text,
    String? file,
  }) {
    return TeacherExperience(
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

  factory TeacherExperience.fromMap(Map<String, dynamic> map) {
    return TeacherExperience(
      value: map['value'] ?? '',
      text: map['text'] ?? '',
      file: map['file']?['small'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherExperience.fromJson(String source) =>
      TeacherExperience.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Опыт работы (Информация: $value, file: $file)';

  @override
  bool operator ==(covariant TeacherExperience other) {
    if (identical(this, other)) return true;

    return other.value == value && other.text == text && other.file == file;
  }

  @override
  int get hashCode => value.hashCode ^ text.hashCode ^ file.hashCode;
}
