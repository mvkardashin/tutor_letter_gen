import 'package:intl/intl.dart';
import 'package:tutor_letter_gen/models/teacher/teacher_surcharge.dart';

import 'package:tutor_letter_gen/services/values.dart';
import '/models/teacher/teacher_group.dart';
import '/models/teacher/teacher_advance.dart';
import '/models/teacher/teacher_degree.dart';
import '/models/teacher/teacher_education.dart';
import '/models/teacher/teacher_experience.dart';
import '/models/teacher/teacher_honor.dart';

import '/models/teacher/teacher_lesson.dart';
import '/models/teacher/teacher_rank.dart';

import 'teacher_item.dart';

class Teacher {
  final int id; // ID;
  final String repetitor; // Описание репетитора;
  final String photoSmall; // Размер изображения не более 250 пк;
  final List<TeacherSurcharge> surcharges;
  final String url; // URL анкеты;
  final String userFullname; // ФИО преподавателя;

  final int statusId; // ID статуса анкеты TeacherStatus;
  final int subjectId; // ID предмета Subject;
  final List<int> categories; // Категории предмета;
  final List<int> positions; // Статус преподавателя;
  final String workPretty; // Стаж;
  final int locationId; // ID региона Location;
  final List<TeacherLesson> localLessons;
  final List<TeacherLesson> departureLessons;
  final List<TeacherLesson> remoteLessons; // Цены занятий;
  final String
      timeLocalPretty; // Допустимые часы занятий у репетитора в HTML-формате;
  final String
      timeDeparturePretty; // Допустимые часы занятий у ученика в HTML-формате;
  final String
      timeRemotePretty; // Допустимые часы дистанционных занятий в HTML-формате;
  final List<int> areaLocal; // Районы занятий у репетитора;
  final List<int> areaDeparture; // Районы занятий у ученика;
  final List<int> metroLocal; // Метро занятий у репетитора;
  final List<int> metroDeparture; // Метро занятий у ученика;
  final List<TeacherEducation> educations; // Образование;
  final List<TeacherExperience> experience; // Опыт работы;
  final List<TeacherDegree> degree; // Ученая степень;
  final List<TeacherRank> rank; // Ученое звание;
  final List<TeacherHonor> honor; // Почетные звания;
  final List<TeacherItem> advance; // Прочие достижения;
  final String text; // Дополнительные данные, о себе;
  final String video; // Видеопрезентация;
  final List<String> actions;
  final String lastReturnText;
  final bool groupAvailabled;
  final List<String> groupReasons;
  final List<TeacherGroup> groups;

  Teacher(
      {required this.id,
      required this.url,
      required this.lastReturnText,
      required this.repetitor,
      required this.photoSmall,
      required this.userFullname,
      required this.statusId,
      required this.subjectId,
      required this.categories,
      required this.positions,
      required this.workPretty,
      required this.locationId,
      required this.localLessons,
      required this.departureLessons,
      required this.remoteLessons,
      required this.timeLocalPretty,
      required this.timeDeparturePretty,
      required this.timeRemotePretty,
      required this.areaDeparture,
      required this.areaLocal,
      required this.metroDeparture,
      required this.surcharges,
      required this.metroLocal,
      required this.educations,
      required this.experience,
      required this.degree,
      required this.rank,
      required this.honor,
      required this.advance,
      required this.text,
      required this.video,
      required this.actions,
      required this.groupAvailabled,
      required this.groupReasons,
      required this.groups});

  factory Teacher.fromJSON(Map<String, dynamic> teacher) {
    // категории
    final categories = (teacher['categories'] is List)
        ? (teacher['categories'] as List)
            .map((e) => (e['id'] as num?)?.toInt() ?? 0)
            .toList()
        : <int>[];

    final surcharges = (teacher['teacher-category'] is List)
        ? (teacher['teacher-category'] as List)
            .map((e) => TeacherSurcharge.fromMap(e))
            .toList()
        : <TeacherSurcharge>[];

    // позиции
    final positions = (teacher['positions'] is List)
        ? (teacher['positions'] as List)
            .map((e) => (e['id'] as num?)?.toInt() ?? 0)
            .toList()
        : <int>[];

    // группы
    final groups = (teacher['groups'] is List)
        ? (teacher['groups'] as List)
            .map((e) => TeacherGroup.fromJson(e))
            .where((e) => e.statusId != 50 && e.statusId != 40)
            .toList()
        : <TeacherGroup>[];

    // уроки
    final localLessons = <TeacherLesson>[];
    final departureLessons = <TeacherLesson>[];
    final remoteLessons = <TeacherLesson>[];

    if (teacher['lessons'] is List) {
      for (final element in teacher['lessons'] as List) {
        final lesson = TeacherLesson.fromMap(element);
        switch (lesson.place) {
          case 1:
            localLessons.add(lesson);
            break;
          case 2:
            departureLessons.add(lesson);
            break;
          case 3:
            remoteLessons.add(lesson);
            break;
        }
      }
    }

    // районы занятий у репетитора
    final areaLocal = (teacher['area-local'] is List)
        ? (teacher['area-local'] as List)
            .map((e) => (e['id'] as num?)?.toInt() ?? 0)
            .toList()
        : <int>[];

    // районы занятий у ученика
    final areaDeparture = (teacher['area-departure'] is List)
        ? (teacher['area-departure'] as List)
            .map((e) => (e['id'] as num?)?.toInt() ?? 0)
            .toList()
        : <int>[];

    // метро у репетитора
    final metroLocal = (teacher['metro-local'] is List)
        ? (teacher['metro-local'] as List)
            .map((e) => (e['id'] as num?)?.toInt() ?? 0)
            .toList()
        : <int>[];

    // метро у ученика
    final metroDeparture = (teacher['metro-departure'] is List)
        ? (teacher['metro-departure'] as List)
            .map((e) => (e['id'] as num?)?.toInt() ?? 0)
            .toList()
        : <int>[];

    // образование
    final educations = (teacher['educations'] is List)
        ? (teacher['educations'] as List)
            .map((e) => TeacherEducation.fromMap(e))
            .toList()
        : <TeacherEducation>[];

    // опыт
    final experience = (teacher['experience'] is List)
        ? (teacher['experience'] as List)
            .map((e) => TeacherExperience.fromMap(e))
            .toList()
        : <TeacherExperience>[];

    // степени
    final degree = (teacher['degree'] is List)
        ? (teacher['degree'] as List)
            .map((e) => TeacherDegree.fromMap(e))
            .toList()
        : <TeacherDegree>[];

    // звания
    final rank = (teacher['rank'] is List)
        ? (teacher['rank'] as List).map((e) => TeacherRank.fromMap(e)).toList()
        : <TeacherRank>[];

    // награды
    final honor = (teacher['honor'] is List)
        ? (teacher['honor'] as List)
            .map((e) => TeacherHonor.fromMap(e))
            .toList()
        : <TeacherHonor>[];

    // доп. достижения
    final advance = (teacher['advance'] is List)
        ? (teacher['advance'] as List)
            .map((e) => TeacherAdvance.fromMap(e))
            .toList()
        : <TeacherAdvance>[];

    // объединённый список
    final fullAdvance = [...advance, ...honor];

    // акции
    final actions = (teacher['actions'] is List)
        ? (teacher['actions'] as List)
            .map((e) => e['value'] as String? ?? '')
            .where((s) => s.isNotEmpty)
            .toList()
        : <String>[];

    // причины группы
    final groupReasons = (teacher['group_reasons'] is List)
        ? (teacher['group_reasons'] as List)
            .map((e) => e as String? ?? '')
            .where((s) => s.isNotEmpty)
            .toList()
        : <String>[];

    return Teacher(
      id: (teacher['id'] as num?)?.toInt() ?? 0,
      url: teacher['url'] as String? ?? '',
      repetitor: teacher['repetitor'] as String? ?? '',
      photoSmall: teacher['photo']?['small'] as String? ?? '',
      userFullname: teacher['user']?['fullname'] as String? ?? 'Нет информации',
      statusId: (teacher['status']?['id'] as num?)?.toInt() ?? 0,
      subjectId: (teacher['subject']?['id'] as num?)?.toInt() ?? 0,
      categories: categories,
      surcharges: surcharges,
      positions: positions,
      workPretty: teacher['work-pretty'] as String? ?? 'Нет информации о стаже',
      locationId: (teacher['location']?['id'] as num?)?.toInt() ?? 0,
      localLessons: localLessons,
      departureLessons: departureLessons,
      remoteLessons: remoteLessons,
      timeDeparturePretty: teacher['time-departure-pretty'] as String? ?? '',
      timeLocalPretty: teacher['time-local-pretty'] as String? ?? '',
      timeRemotePretty: teacher['time-remote-pretty'] as String? ?? '',
      areaDeparture: areaDeparture,
      areaLocal: areaLocal,
      metroLocal: metroLocal,
      metroDeparture: metroDeparture,
      educations: educations,
      experience: experience,
      degree: degree,
      rank: rank,
      honor: honor,
      advance: fullAdvance,
      text: teacher['text'] as String? ?? '',
      video: teacher['video']?['code'] as String? ?? '',
      actions: actions,
      lastReturnText: teacher['lastReturnText'] as String? ?? '',
      groupAvailabled: teacher['group_availabled'] as bool? ?? false,
      groupReasons: groupReasons,
      groups: groups,
    );
  }

  // factory Teacher.fromJSON(Map teacher) {
  //   List<int> arrayCategories = [];
  //   List<int> positions = [];
  //   arrayCategories = teacher['categories']?.isNotEmpty
  //       ? List<int>.from(teacher['categories'].map((e) => e['id']).toList())
  //       : [];
  //   positions = teacher['positions']?.isNotEmpty
  //       ? List<int>.from(teacher['positions'].map((e) => e['id']).toList())
  //       : [];
  //   List<TeacherGroup> groups = teacher['groups']?.isNotEmpty
  //       ? List<TeacherGroup>.from(
  //               teacher['groups'].map((e) => TeacherGroup.fromJson(e)).toList())
  //           .where((e) => e.statusId != 50 && e.statusId != 40)
  //           .toList()
  //       : [];

  //   List<TeacherLesson> localLessons = [];
  //   List<TeacherLesson> departureLessons = [];
  //   List<TeacherLesson> remoteLessons = [];
  //   if (teacher['lessons'].isNotEmpty) {
  //     for (Map<String, dynamic> element in teacher['lessons']) {
  //       TeacherLesson lesson = TeacherLesson.fromMap(element);
  //       switch (lesson.place) {
  //         case 1:
  //           localLessons.add(lesson);
  //           break;
  //         case 2:
  //           departureLessons.add(lesson);
  //           break;
  //         case 3:
  //           remoteLessons.add(lesson);
  //           break;
  //       }
  //     }
  //   }

  //   // Районы занятий у репетитора;
  //   List<int> areaLocal = teacher['area-local']?.isNotEmpty
  //       ? List<int>.from(teacher['area-local'].map((e) => e['id']).toList())
  //       : [];

  //   // Районы занятий у ученика;
  //   List<int> areaDeparture = teacher['area-departure']?.isNotEmpty
  //       ? List<int>.from(teacher['area-departure'].map((e) => e['id']).toList())
  //       : [];

  //   // Метро занятий у репетитора;
  //   List<int> metroLocal = teacher['metro-local']?.isNotEmpty
  //       ? List<int>.from(teacher['metro-local'].map((e) => e['id']).toList())
  //       : [];

  //   List<int> metroDeparture = teacher['metro-departure']?.isNotEmpty
  //       ? List<int>.from(
  //           teacher['metro-departure'].map((e) => e['id']).toList())
  //       : [];

  //   List<TeacherEducation> educations = teacher['educations']?.isNotEmpty
  //       ? List<TeacherEducation>.from(teacher['educations']
  //           .map((e) => TeacherEducation.fromMap(e))
  //           .toList())
  //       : [];

  //   List<TeacherExperience> experience = teacher['experience']?.isNotEmpty
  //       ? List<TeacherExperience>.from(teacher['experience']
  //           .map((e) => TeacherExperience.fromMap(e))
  //           .toList())
  //       : [];

  //   List<TeacherDegree> degree = teacher['degree']?.isNotEmpty
  //       ? List<TeacherDegree>.from(
  //           teacher['degree']?.map((e) => TeacherDegree.fromMap(e)).toList())
  //       : [];

  //   // List rank = [];

  //   // if (teacher['rank'].isNotEmpty) {
  //   List<TeacherRank> rank = teacher['rank']?.isNotEmpty
  //       ? List<TeacherRank>.from(
  //           teacher['rank'].map((e) => TeacherRank.fromMap(e)).toList())
  //       : [];

  //   // List honor = [];

  //   List<TeacherHonor> honor = teacher['honor']?.isNotEmpty
  //       ? List<TeacherHonor>.from(
  //           teacher['honor'].map((e) => TeacherHonor.fromMap(e)).toList())
  //       : [];

  //   List<TeacherAdvance> advance = teacher['advance']?.isNotEmpty
  //       ? List<TeacherAdvance>.from(
  //           teacher['advance'].map((e) => TeacherAdvance.fromMap(e)).toList())
  //       : [];

  //   List<TeacherItem> fullAdvance = [...advance, ...honor];

  //   List<String> actions = teacher['actions']?.isNotEmpty
  //       ? List<String>.from(
  //           teacher['actions'].map((e) => e['value'] ?? '').toList())
  //       : [];
  //   List<String> groupReasons = teacher['group_reasons']?.isNotEmpty
  //       ? List<String>.from(
  //           teacher['group_reasons'].map((e) => e ?? '').toList())
  //       : [];
  //   // debugPrint(teacher['group_reasons']);

  //   return Teacher(
  //       id: teacher['id']?.toInt() ?? 0,
  //       url: teacher['url'] ?? '',
  //       repetitor: teacher['repetitor'] ?? '',
  //       photoSmall: teacher['photo']?['small'] ?? '',
  //       userFullname: teacher['user']?['fullname'] ?? 'Нет информации',
  //       statusId: teacher['status']?['id']?.toInt() ?? 0,
  //       subjectId: teacher['subject']?['id']?.toInt() ?? 0,
  //       categories: arrayCategories,
  //       positions: positions,
  //       workPretty: teacher['work-pretty'] ?? 'Нет информации о стаже',
  //       locationId: teacher['location']?['id']?.toInt() ?? 0,
  //       localLessons: localLessons,
  //       departureLessons: departureLessons,
  //       remoteLessons: remoteLessons,
  //       timeDeparturePretty: teacher['time-departure-pretty'] ?? '',
  //       timeLocalPretty: teacher['time-local-pretty'] ?? '',
  //       timeRemotePretty: teacher['time-remote-pretty'] ?? '',
  //       areaDeparture: areaDeparture,
  //       areaLocal: areaLocal,
  //       metroLocal: metroLocal,
  //       metroDeparture: metroDeparture,
  //       educations: educations,
  //       experience: experience,
  //       degree: degree,
  //       rank: rank,
  //       honor: honor,
  //       advance: fullAdvance,
  //       text: teacher['text'] ?? '',
  //       video: teacher['video']?['code'] ?? '',
  //       actions: actions,
  //       lastReturnText: teacher['lastReturnText'] ?? '',
  //       groupAvailabled: teacher['group_availabled'] ?? false,
  //       groupReasons: groupReasons,
  //       groups: groups);
  // }

  Teacher copyWith(
      {int? id,
      String? repetitor,
      String? photoSmall,
      String? url,
      String? userFullname,
      int? statusId,
      int? subjectId,
      List<int>? categories,
      List<int>? positions,
      String? workPretty,
      int? locationId,
      List<TeacherLesson>? localLessons,
      List<TeacherLesson>? departureLessons,
      List<TeacherLesson>? remoteLessons,
      List<int>? areaLocal,
      List<int>? areaDeparture,
      List<int>? metroLocal,
      List<int>? metroDeparture,
      List<TeacherEducation>? educations,
      List<TeacherExperience>? experience,
      List<TeacherDegree>? degree,
      List<TeacherRank>? rank,
      List<TeacherHonor>? honor,
      List<TeacherAdvance>? advance,
      List<TeacherSurcharge>? surcharges,
      String? text,
      String? video,
      List<String>? actions,
      String? lastReturnText,
      String? timeDeparturePretty,
      String? timeLocalPretty,
      String? timeRemotePretty,
      bool? groupAvailabled,
      List<String>? groupReasons,
      List<TeacherGroup>? groups}) {
    return Teacher(
        id: id ?? this.id,
        repetitor: repetitor ?? this.repetitor,
        photoSmall: photoSmall ?? this.photoSmall,
        url: url ?? this.url,
        userFullname: userFullname ?? this.userFullname,
        statusId: statusId ?? this.statusId,
        surcharges: surcharges ?? this.surcharges,
        subjectId: subjectId ?? this.subjectId,
        categories: categories ?? this.categories,
        positions: positions ?? this.positions,
        workPretty: workPretty ?? this.workPretty,
        locationId: locationId ?? this.locationId,
        localLessons: localLessons ?? this.localLessons,
        departureLessons: departureLessons ?? this.departureLessons,
        remoteLessons: remoteLessons ?? this.remoteLessons,
        timeLocalPretty: timeLocalPretty ?? this.timeLocalPretty,
        timeDeparturePretty: timeDeparturePretty ?? this.timeDeparturePretty,
        timeRemotePretty: timeRemotePretty ?? this.timeRemotePretty,
        areaLocal: areaLocal ?? this.areaLocal,
        areaDeparture: areaDeparture ?? this.areaDeparture,
        metroLocal: metroLocal ?? this.metroLocal,
        metroDeparture: metroDeparture ?? this.metroDeparture,
        educations: educations ?? this.educations,
        experience: experience ?? this.experience,
        degree: degree ?? this.degree,
        rank: rank ?? this.rank,
        honor: honor ?? this.honor,
        advance: advance ?? this.advance,
        text: text ?? this.text,
        video: video ?? this.video,
        actions: actions ?? this.actions,
        lastReturnText: lastReturnText ?? this.lastReturnText,
        groupAvailabled: groupAvailabled ?? this.groupAvailabled,
        groupReasons: groupReasons ?? this.groupReasons,
        groups: groups ?? this.groups
        // domain_uk: domain_uk ?? this.domain_uk,
        );
  }

  String get localStationsPlural =>
      '${metroLocal.length} ${Intl.plural(metroLocal.length, zero: 'станций', one: 'станция', two: 'станции', other: 'cтанций')}';

  String get departureStationsPlural =>
      '${metroDeparture.length} ${Intl.plural(metroDeparture.length, zero: 'станций', one: 'станция', two: 'станции', other: 'cтанций')}';

  String get localAreasPlural =>
      '${areaLocal.length} ${Intl.plural(areaLocal.length, zero: 'районов', one: 'район', two: 'района', other: 'районов')}';

  String get departureAreasPlural =>
      '${areaDeparture.length} ${Intl.plural(areaDeparture.length, zero: 'районов', one: 'район', two: 'района', other: 'районов')}';
  String get timeLocalFormatted => timeLocalPretty != ''
      ? timeLocalPretty
          .replaceAll('<div>', '')
          .replaceAll('</div>', '\n')
          .trimRight()
      : 'Не заполнено';
  // bool get isLocalTimeEmpty
  String get timeDepartureFormatted => timeDeparturePretty != ''
      ? timeDeparturePretty
          .replaceAll('<div>', '')
          .replaceAll('</div>', '\n')
          .trimRight()
      : 'Не заполнено';
  String get timeOnlineFormatted => timeRemotePretty != ''
      ? timeRemotePretty
          .replaceAll('<div>', '')
          .replaceAll('</div>', '\n')
          .trimRight()
      : 'Не заполнено';

  List<String> get prettySurcharges {
    final List<String> res = [];
    for (final TeacherSurcharge s in surcharges) {
      final String name = subjects[s.subjectId] ?? '';
      String str = "\nКатегория: $name, надбавка: ${s.cost} руб.";
      res.add(str);
    }

    return res;
  }

  bool get isOnCheck => statusId == 20;
  bool get isReturn => statusId == 15;

  bool get isDepartureReady =>
      departureLessons.isNotEmpty &&
      (metroDeparture.isNotEmpty || areaDeparture.isNotEmpty) &&
      timeDeparturePretty.isNotEmpty;
  bool get isDepartureIncomplete =>
      departureLessons.isNotEmpty &&
      ((metroDeparture.isEmpty && areaDeparture.isEmpty) ||
          timeDeparturePretty.isEmpty);

  bool get isLocalReady =>
      localLessons.isNotEmpty &&
      (metroLocal.isNotEmpty || areaLocal.isNotEmpty) &&
      timeLocalPretty.isNotEmpty;
  bool get isLocalIncomplete =>
      localLessons.isNotEmpty &&
      ((metroLocal.isEmpty && areaLocal.isEmpty) || timeLocalPretty.isEmpty);

  bool get isOnlineReady => remoteLessons.isNotEmpty && timeRemotePretty != '';
  bool get isOnlineIncomplete =>
      remoteLessons.isNotEmpty && timeRemotePretty == '';

  bool get anyReady => isOnlineReady || isDepartureReady || isLocalReady;
  bool get hasIncomplete =>
      isOnlineIncomplete || isDepartureIncomplete || isLocalIncomplete;

  bool get isActive => statusId != 1 && statusId != 50 && statusId != 40;
  bool get isAdvances => honor.isNotEmpty || advance.isNotEmpty;

  int get areaLocalCount => areaLocal.length;
  int get areaDepartureCount => areaDeparture.length;
  int get metroLocalCount => metroLocal.length;
  int get metroDepartureCount => metroDeparture.length;
  int get educationsCount => educations.length;
  int get experienceCount => experience.length;
  int get degreeCount => degree.length;
  int get rankCount => rank.length;
  int get honorCount => honor.length;
  int get advanceCount => advance.length;
  int get groupsCount => groups.length;
  String get categoriesNames {
    return categories.map((e) => subjects[e] ?? '').toList().toString();
  }

  String get subjectName => subjects[subjectId] ?? '';
  String get positionsNames {
    return positions.map((e) => teacherTypes[e] ?? '').toList().toString();
  }

  List<String> get lessonsNormalized {
    return alllessons
        .map((e) =>
            "\nЗанятие (${lessonPlaces[e.place]}. ${lessonFormats[e.size]}.  ${ageCategories[e.age]} - ${lessonDurations[e.duration]} за ${e.cost} рублей)")
        .toList();
  }

  String get lessonPricesOnly {
    return "Цены занятий репетитора:\n${alllessons.map((e) => "\n${e.cost} р").join('\n')}";
  }

  bool get hasOffline {
    return alllessons.any((l) => l.place == 1 || l.place == 2);
  }

  double? get basePriceMinRub {
    if (alllessons.isEmpty) return null;
    final costs = alllessons.map((l) => l.cost).toList();
    return costs.isEmpty
        ? null
        : costs.reduce((a, b) => a < b ? a : b).toDouble();
  }

  bool get hasEgeCategory {
    for (final int c in categories) {
      if (egeCategoriesId.contains(c)) {
        return true;
      }
    }
    return false;
  }

  bool get hasAgeId4 {
    return alllessons.any((lesson) => lesson.age == egeReqiredAgeId);
  }

  static const int egeReqiredAgeId = 4;
  static const List<int> egeCategoriesId = [
    104,
    120,
    131,
    134,
    137,
    141,
    145,
    148,
    151,
    154,
    158,
    166,
    174,
    283,
    287,
    392,
  ];

  String? get egeIssue {
    if (!hasEgeCategory) {
      return null; // правило не применимо
    }
    if (!hasAgeId4) {
      return "AGE_MISSING_FOR_EGE";
    }
    return null;
  }

  String? get checkEmptyGeo {
    bool hasLocalLesson = false;
    bool hasDepartureLesson = false;
    String? issue;

    for (final lesson in alllessons) {
      if (lesson.place == 1) {
        // у преподавателя
        hasLocalLesson = true;
      }
      if (lesson.place == 2) {
        // выезд к ученику
        hasDepartureLesson = true;
      }
    }

    if (hasLocalLesson && areaLocalCount == 0 && metroLocalCount == 0) {
      issue = "EMPTY_GEO";
    }

    if (hasDepartureLesson &&
        areaDepartureCount == 0 &&
        metroDepartureCount == 0) {
      issue = "EMPTY_GEO";
    }
    return issue;
  }

  final Map<String, RegExp> _scripts = {
    "ru": RegExp(r"[А-Яа-яЁё]"), // кириллица
    "uk": RegExp(r"[ҐґЄєІіЇї]"), // украинские буквы
    "en": RegExp(r"[A-Za-z]"), // латиница
    "tr": RegExp(r"[ÇĞİÖŞÜçğıöşü]"), // турецкие
    "he": RegExp(r"[א-ת]"), // иврит
    "ar": RegExp(r"[\u0600-\u06FF]"), // арабский
    "zh": RegExp(r"[\u4E00-\u9FFF]"), // китайские иероглифы
    "ja_hira": RegExp(r"[ぁ-ん]"), // японская хирагана
    "ja_kata": RegExp(r"[ァ-ン]"), // японская катакана
    "el": RegExp(r"[Ά-ώΑ-ω]"), // греческий
  };

  String? get checkFullname =>
      userFullname.split(' ').length < 3 ? "INCOMPLETE_FULL_NAME" : null;

  double _scriptRatio(String text, RegExp pattern) {
    if (text.isEmpty) return 0.0;
    final matches = pattern.allMatches(text);
    return matches.length / text.length;
  }

  String _detectTextLanguage(String text) {
    if (text.trim().isEmpty) return "empty";

    final scores = <String, double>{
      "ru": _scriptRatio(text, _scripts["ru"]!),
      "uk": _scriptRatio(text, _scripts["uk"]!),
      "en": _scriptRatio(text, _scripts["en"]!),
      "tr": _scriptRatio(text, _scripts["tr"]!),
      "he": _scriptRatio(text, _scripts["he"]!),
      "ar": _scriptRatio(text, _scripts["ar"]!),
      "zh": _scriptRatio(text, _scripts["zh"]!),
      "ja": [
        _scriptRatio(text, _scripts["ja_hira"]!),
        _scriptRatio(text, _scripts["ja_kata"]!)
      ].reduce((a, b) => a > b ? a : b),
      "el": _scriptRatio(text, _scripts["el"]!),
    };

    final bestEntry =
        scores.entries.reduce((a, b) => a.value > b.value ? a : b);
    final langByScript = bestEntry.key;
    final topScore = bestEntry.value;

    if (topScore >= 0.25) {
      if (langByScript == "ru" && scores["uk"]! >= 0.05) {
        return "uk";
      }
      return langByScript;
    }

    return "unknown";
  }

  String? get codeForeignLanguageAbout {
    final detected = _detectTextLanguage(text);
    if (detected != "ru") {
      return "FOREIGN_LANGUAGE_ABOUT";
    }
    return null;
  }

  String? get checkLocalGeo {
    final locals = areaLocalCount + metroLocalCount;
    if (locals > 10) {
      return "TOO_MANY_LOCAL_GEO";
    }
    return null;
  }

  static const int ogeAgeId = 3;
  static const String egeCategoryName = "огэ";
  static const List<int> ogeCategories = [
    105,
    121,
    132,
    135,
    138,
    142,
    146,
    149,
    152,
    155,
    159,
    167,
    175,
    284
  ];

  bool get _hasOgeCategory {
    // Проверяем, есть ли категория из списка OGE_CATEGORY_ID
    for (final c in categories) {
      if (ogeCategories.contains(c)) {
        return true;
      }
    }
    return false;
  }

  List<TeacherLesson> get alllessons => [
        ...localLessons,
        ...departureLessons,
        ...remoteLessons,
      ];

  bool get _hasOgeAgeId {
    // Проверяем, есть ли урок с нужным ageId
    return alllessons.any((lesson) => lesson.age == 3);
  }

  String? get checkOgeAgeRequire {
    /// Правило:
    /// Если есть категория "Подготовка к ОГЭ",
    /// то должен быть возраст "Школьники с 5 по 9 класс" (id=3).
    if (!_hasOgeCategory) {
      return null; // правило не применимо
    }

    final ok = _hasOgeAgeId;
    if (!ok) {
      return "AGE_MISSING_FOR_OGE";
    }

    return null;
  }

  String? get checkMinPrice {
    // Правило:
    // Если цена ниже 800 рублей → возвращаем проблему
    if (alllessons.any((lesson) => lesson.cost < 800)) {
      return "PRICE_TOO_LOW";
    }
    return null;
  }

  static const Set<int> inPersonPlaceIds = {
    1,
    2
  }; // 1: у преподавателя, 2: у ученика
  static const Set<int> onlinePlaceIds = {3};

  static const List<String> onlineOnlyPatterns = [
    r"\bтолько\s+онлайн\b",
    r"\bтолько\s+дистанц[иы]онн(?:о|ые?)\b",
    r"\bисключительно\s+онлайн\b",
    r"\bзаним\w+\s+онлайн\b(?=.*\b(не|без)\b.*\b(выезд|очно|при[еи]маю)\b)?",
    r"\bочно\s+не\s+заним\w+\b",
    r"\bбез\s+выезда\b",
    r"\bне\s+выезжаю\b",
    r"\bу\s+себя\s+не\s+принимаю\b",
    r"\bочно\s+не\b",
    r"\bтолько\s+по\s+(zoom|скайпу|teams|google\s+meet)\b",
  ];

  bool get textClaimsOnlineOnly {
    var s = text.toLowerCase();
    s = s.replaceAll("ё", "е");

    // Базовые «только онлайн»
    for (final pattern in [
      onlineOnlyPatterns[0],
      onlineOnlyPatterns[1],
      onlineOnlyPatterns[2],
      onlineOnlyPatterns[9],
    ]) {
      if (RegExp(pattern).hasMatch(s)) return true;
    }

    // Частные запреты
    if (RegExp(r"\bбез\s+выезда\b|\bне\s+выезжаю\b").hasMatch(s)) return true;
    if (RegExp(r"\bу\s+себя\s+не\s+принимаю\b|\bне\s+принимаю\s+очно\b")
        .hasMatch(s)) {
      return true;
    }
    if (RegExp(r"\bочно\s+не\s+заним\w+|\bбез\s+очных\b|\bочно\s+не\b")
        .hasMatch(s)) {
      return true;
    }

    return false;
  }

  bool get hasInPersonInPrices {
    bool hasDeparture = false;
    bool hasAtTutor = false;

    for (final lesson in alllessons) {
      final placeId = lesson.place;
      if (inPersonPlaceIds.contains(placeId)) {
        if (placeId == 1) {
          hasAtTutor = true;
        } else if (placeId == 2) {
          hasDeparture = true;
        }
      }
    }
    return hasDeparture || hasAtTutor;
  }

  String? get checkOnlineVsInPersonConflict {
    final textFlag = textClaimsOnlineOnly;
    final priceFlag = hasInPersonInPrices;

    if (textFlag && priceFlag) {
      return "ONLINE_ONLY_TEXT_CONFLICTS_WITH_IN_PERSON_PRICES";
    }

    return null;
  }
}
