// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'dart:convert';

import '/models/teacher/teacher_item.dart';

class TeacherHonor extends TeacherItem {
  TeacherHonor({
    required super.value,
    required super.file,
  });

  TeacherHonor copyWith({
    String? value,
    String? file,
  }) {
    return TeacherHonor(
      value: value ?? this.value,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'file': file,
    };
  }

  factory TeacherHonor.fromMap(Map<String, dynamic> map) {
    return TeacherHonor(
      value: map['value'] ?? '',
      file: map['file']?['small'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherHonor.fromJson(String source) =>
      TeacherHonor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Достижения (Текст: $value, Скан документа: $file)';

  @override
  bool operator ==(covariant TeacherHonor other) {
    if (identical(this, other)) return true;

    return other.value == value && other.file == file;
  }

  @override
  int get hashCode => value.hashCode ^ file.hashCode;
}
