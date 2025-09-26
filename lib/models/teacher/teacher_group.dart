import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_letter_gen/services/values.dart';

class TeacherGroup {
  final int id;
  final int teacherId;
  final int subjectId;
  final int statusId;
  final int lessonDuration;
  final int lessonCount;
  final int lessonCost;
  final int peopleCount;
  final String assistantText;
  final String scheduleText;
  final int startedAt;
  final String joinText;
  final String organizationText;
  final String financialText;
  final int disabledAt;
  final int createdAt;
  final int updatedAt;
  final String returnText;
  final String joinNowText;
  final String joinLaterText;
  final int typeJoin;
  final int ageId;
  final String level;
  final String aboutText;

  TeacherGroup({
    required this.id,
    required this.teacherId,
    required this.subjectId,
    required this.statusId,
    required this.lessonDuration,
    required this.lessonCount,
    required this.lessonCost,
    required this.peopleCount,
    required this.assistantText,
    required this.scheduleText,
    required this.startedAt,
    required this.joinText,
    required this.organizationText,
    required this.financialText,
    required this.disabledAt,
    required this.createdAt,
    required this.updatedAt,
    required this.returnText,
    required this.joinNowText,
    required this.joinLaterText,
    required this.typeJoin,
    required this.ageId,
    required this.level,
    required this.aboutText,
  });

  factory TeacherGroup.fromJson(Map<String, dynamic> json) {
    return TeacherGroup(
      id: json['id'] ?? 0,
      teacherId: json['teacher_id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      statusId: json['status_id'] ?? 0,
      lessonDuration: json['lesson_duration'] ?? 0,
      lessonCount: json['lesson_count'] ?? 0,
      lessonCost: json['lesson_cost'] ?? 0,
      peopleCount: json['people_count'] ?? 0,
      assistantText: json['assistant_text'] ?? '',
      scheduleText: json['schedule_text'] ?? '',
      startedAt: json['started_at'] ?? 0,
      joinText: json['join_text'] ?? '',
      organizationText: json['organization_text'] ?? '',
      financialText: json['financial_text'] ?? '',
      disabledAt: json['disabled_at'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      returnText: json['return_text'] ?? '',
      joinNowText: json['join_now_text'] ?? '',
      joinLaterText: json['join_later_text'] ?? '',
      typeJoin: json['type_join'] ?? 0,
      ageId: json['age_id'] ?? 0,
      level: json['level'] ?? '',
      aboutText: json['about_text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacher_id': teacherId,
      'subject_id': subjectId,
      'status_id': statusId,
      'lesson_duration': lessonDuration,
      'lesson_count': lessonCount,
      'lesson_cost': lessonCost,
      'people_count': peopleCount,
      'assistant_text': assistantText,
      'schedule_text': scheduleText,
      'started_at': startedAt,
      'join_text': joinText,
      'organization_text': organizationText,
      'financial_text': financialText,
      'disabled_at': disabledAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'return_text': returnText,
      'join_now_text': joinNowText,
      'join_later_text': joinLaterText,
      'type_join': typeJoin,
      'age_id': ageId,
      'level': level,
      'about_text': aboutText,
    };
  }

  @override
  String toString() {
    return '''Групповое занятие(id: $id, Номер анкеты: $teacherId, subjectId: ${subjects[subjectId]}, 
    status: $status, Продолжительность урока: $lessonDuration, 
    Количество уроков: $lessonCount, Стоимость урока: $lessonCost, Количество человек(макс): $peopleCount, 
    Будет ли ассистент: $assistantText, Расписание: $scheduleText, 
    Дата начала: $startedAt, Условие присоединения: $joinText, 
    Орг. подробности: $organizationText, 
    Финансовые условия: $financialText, 
    Прием до: $disabledAt, createdAt: $createdAt, updatedAt: $updatedAt, 
    Причина возврата: $returnText, 
    joinNowText: $joinNowText, joinLaterText: $joinLaterText, typeJoin: $typeJoin, 
    Возраст: ${ageCategories[ageId]}, Уровень: $level, О курсе: $aboutText)''';
  }

  DateTime get startedAtDateTime {
    return DateTime.fromMillisecondsSinceEpoch(startedAt * 1000);
  }

  String get startedAtString {
    return DateFormat(DateFormat.YEAR_MONTH_DAY).format(startedAtDateTime);
  }

  bool get isPublished => statusId == 30;

  String get status {
    switch (statusId) {
      case 10:
        return 'Редактирование';
      case 20:
        return 'На проверке';
      case 30:
        return 'Опубликовано';
      case 31:
        return 'Приостановлено';
      case 40:
        return 'В архиве';
      default:
        return 'Нет информации';
    }
  }

  Color get statusColor {
    switch (statusId) {
      case 10:
        return Colors.blue;
      case 20:
        return Colors.orange;
      case 30:
        return Colors.green;
      case 31:
        return Colors.orange;
      case 40:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Color get textStatusColor {
    switch (statusId) {
      case 10:
        return Colors.white;
      case 20:
        return Colors.black;
      case 30:
        return Colors.black;
      case 31:
        return Colors.black;
      case 40:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  String get buttonText {
    switch (statusId) {
      case 10:
        return 'На проверку';
      case 20:
        return 'На проверкe';
      case 30:
        return 'Остановить показ';
      case 31:
        return 'Опубликовать';
      case 40:
        return '';
      default:
        return '';
    }
  }

  Widget get buttonIcon {
    switch (statusId) {
      case 10:
        return const Icon(Icons.send);
      case 20:
        return Container();
      case 30:
        return const Icon(Icons.pause);
      case 31:
        return const Icon(Icons.play_arrow);
      case 40:
        return Container();

      default:
        return Container();
    }
  }
}
