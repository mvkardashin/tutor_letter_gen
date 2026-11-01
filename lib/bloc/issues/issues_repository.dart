import 'package:tutor_letter_gen/models/teacher/teacher.dart';

abstract class IssuesRepositoryImpl {
  Future<List<String>> fetchAiIssues(
      {required Teacher teacher, required String aiErrors});
  Future<String> fetchai(
      {required String systemPrompt, required String userPrompt});
  Future<List<String>> checkMechIssues({required Teacher teacher});
  Future<List<String>> loadIssues({required Teacher teacher});
  Future<List<String>> fetchAllIssues(
      {required Teacher teacher, required String aiErrors});
  // Future<List<String>> fetchPersonalBatchIssue({required Teacher teacher});
}

class IssuesRepository implements IssuesRepositoryImpl {
  List<String> issues = [];
  @override
  Future<List<String>> fetchAiIssues(
      {required Teacher teacher, required String aiErrors}) async {
    List<String> response = ["NATIVE_TUTOR"];
    return response;
  }

  @override
  Future<List<String>> loadIssues({required Teacher teacher}) async {
    List<String> response = ["NATIVE_TUTOR"];
    return response;
  }

  @override
  Future<List<String>> checkMechIssues({required Teacher teacher}) async {
    List<String> issues = [];
    final checks = <String?>[
      teacher.checkOgeAgeRequire,
      teacher.checkFullname,
      teacher.checkLocalGeo,
      teacher.checkEmptyGeo,
      teacher.checkMinPrice,
      teacher.egeIssue,
      teacher.checkOnlineVsInPersonConflict,
      teacher.codeForeignLanguageAbout,
      teacher.egeIssue, // checkTooManySubjects?
    ];

    for (final issue in checks) {
      if (issue != null) {
        issues.add(issue);
      }
    }
    return issues;
  }

  @override
  Future<List<String>> fetchAllIssues(
      {required Teacher teacher, required String aiErrors}) async {
    // Combine AI and mechanical issues
    issues = await Future.wait([
      fetchAiIssues(teacher: teacher, aiErrors: aiErrors),
      checkMechIssues(teacher: teacher)
    ]).then((lists) => lists.expand((list) => list).toList());
    return issues;
  }

  @override
  Future<String> fetchai(
      {required String systemPrompt, required String userPrompt}) async {
    // String response = await ApiService()
    //     .fetchAiIssues(errorPrompt: systemPrompt, teacherJson: userPrompt);
    String response = '';
    return response;
  }
}
