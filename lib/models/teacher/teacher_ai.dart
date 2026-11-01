// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_dynamic_calls

import 'package:tutor_letter_gen/models/teacher/teacher.dart';

class TeacherAI {
  final int id; // ID;
  final String repetitor; // Описание репетитора;
  final String photoSmall; // Размер изображения не более 250 пк;
  final String url; // URL анкеты;
  final String userFullname; // ФИО преподавателя;
  final String subject; // ID предмета Subject;
  final String categories; // Категории предмета;
  final String positions; // Статус преподавателя;
  final String lessonsPretty;
  final String surcharges;
  final String
      timeLocalPretty; // Допустимые часы занятий у репетитора в HTML-формате;
  final String
      timeDeparturePretty; // Допустимые часы занятий у ученика в HTML-формате;
  final String
      timeRemotePretty; // Допустимые часы дистанционных занятий в HTML-формате;
  final int areaLocalCount; // Районы занятий у репетитора;
  final int areaDepartureCount; // Районы занятий у ученика;
  final int metroLocalCount; // Метро занятий у репетитора;
  final int metroDepartureCount; // Метро занятий у ученика;
  final String educations; // Образование;
  final String experience; // Опыт работы;
  final String degree; // Ученая степень;
  final String rank; // Ученое звание;
  final String honor; // Почетные звания;
  final String advance; // Прочие достижения;
  final String text; // Дополнительные данные, о себе;
  final String actions;
  final String groups;

  factory TeacherAI.fromTeacher(Teacher teacher) {
    return TeacherAI(
        id: teacher.id,
        repetitor: teacher.repetitor,
        surcharges: teacher.prettySurcharges.join('; '),
        photoSmall: teacher.photoSmall,
        url: teacher.url,
        userFullname: teacher.userFullname,
        subject: teacher.subjectName,
        categories: teacher.categoriesNames,
        positions: teacher.positionsNames,
        lessonsPretty: teacher.lessonsNormalized.toString(),
        timeLocalPretty: teacher.timeLocalFormatted,
        timeDeparturePretty: teacher.timeDepartureFormatted,
        timeRemotePretty: teacher.timeOnlineFormatted,
        areaLocalCount: teacher.areaLocalCount,
        areaDepartureCount: teacher.areaDepartureCount,
        metroLocalCount: teacher.metroLocalCount,
        metroDepartureCount: teacher.metroDepartureCount,
        educations:
            teacher.educations.map((e) => e.toPrettyString()).join('; '),
        experience: teacher.experience.toString(),
        degree: teacher.degree.toString(),
        rank: teacher.rank.toString(),
        honor: teacher.honor.toString(),
        advance: teacher.advance.toString(),
        text: teacher.text,
        actions: teacher.actions.toString(),
        groups: teacher.groups.toString());
  }

  TeacherAI(
      {required this.id,
      required this.repetitor,
      required this.photoSmall,
      required this.surcharges,
      required this.url,
      required this.userFullname,
      required this.subject,
      required this.categories,
      required this.positions,
      required this.lessonsPretty,
      required this.timeLocalPretty,
      required this.timeDeparturePretty,
      required this.timeRemotePretty,
      required this.areaLocalCount,
      required this.areaDepartureCount,
      required this.metroLocalCount,
      required this.metroDepartureCount,
      required this.educations,
      required this.experience,
      required this.degree,
      required this.rank,
      required this.honor,
      required this.advance,
      required this.text,
      required this.actions,
      required this.groups});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'repetitor': repetitor,
      'photoSmall': photoSmall,
      'surcharges': surcharges,
      'url': url,
      'userFullname': userFullname,
      'subject': subject,
      'categories': categories,
      'positions': positions,
      'lessonsPretty': lessonsPretty,
      'timeLocalPretty': timeLocalPretty,
      'timeDeparturePretty': timeDeparturePretty,
      'timeRemotePretty': timeRemotePretty,
      'areaLocalCount': areaLocalCount,
      'areaDepartureCount': areaDepartureCount,
      'metroLocalCount': metroLocalCount,
      'metroDepartureCount': metroDepartureCount,
      'educations': educations,
      'experience': experience,
      'degree': degree,
      'rank': rank,
      'honor': honor,
      'advance': advance,
      'text': text,
      'actions': actions,
      'groups': groups,
    };
  }
}
