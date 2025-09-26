// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'dart:convert';

import '/models/teacher/teacher_item.dart';

class TeacherEducation extends TeacherItem {
  // String value;
  String faculty;
  String specialty;
  String qualification;
  String year;
  // String file;
  TeacherEducation({
    required super.value,
    required this.faculty,
    required this.specialty,
    required this.qualification,
    required this.year,
    required super.file,
  });

  TeacherEducation copyWith({
    String? value,
    String? faculty,
    String? specialty,
    String? qualification,
    String? year,
    String? file,
  }) {
    return TeacherEducation(
      value: value ?? this.value,
      faculty: faculty ?? this.faculty,
      specialty: specialty ?? this.specialty,
      qualification: qualification ?? this.qualification,
      year: year ?? this.year,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'faculty': faculty,
      'specialty': specialty,
      'qualification': qualification,
      'year': year,
      'file': file,
    };
  }

  factory TeacherEducation.fromMap(Map<String, dynamic> map) {
    return TeacherEducation(
      value: map['title'] ?? '',
      faculty: map['faculty'] ?? '',
      specialty: map['specialty'] ?? '',
      qualification: map['qualification'] ?? '',
      year: map['year'] != null ? map['year'].toString() : '',
      file: map['file']?['small'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherEducation.fromJson(String source) =>
      TeacherEducation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherEducation(value: $value, faculty: $faculty, specialty: $specialty, qualification: $qualification, year: $year, file: $file)';
  }

  String toPrettyString() {
    return 'Образование(Учебное заведение: $value, Факультет: $faculty, Специальность: $specialty, Квалификация: $qualification, Год окончания: $year, Скан копия диплома: $file)';
  }

  @override
  bool operator ==(covariant TeacherEducation other) {
    if (identical(this, other)) return true;

    return other.value == value &&
        other.faculty == faculty &&
        other.specialty == specialty &&
        other.qualification == qualification &&
        other.year == year &&
        other.file == file;
  }

  @override
  int get hashCode {
    return value.hashCode ^
        faculty.hashCode ^
        specialty.hashCode ^
        qualification.hashCode ^
        year.hashCode ^
        file.hashCode;
  }
}
