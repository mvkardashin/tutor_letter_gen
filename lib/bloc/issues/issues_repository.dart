import 'package:tutor_letter_gen/models/issue.dart';
import 'package:tutor_letter_gen/models/teacher/teacher.dart';

abstract class IssuesRepositoryImpl {
  Future<List<Issue>> fetchAiIssues({required Teacher teacher});
  Future<List<Issue>> checkMechIssues({required Teacher teacher});
  Future<List<Issue>> loadIssues({required Teacher teacher});
  Future<List<Issue>> fetchAllIssues({required Teacher teacher});
}

class IssuesRepository implements IssuesRepositoryImpl {
  @override
  Future<List<Issue>> fetchAiIssues({required Teacher teacher}) async {
    // Simulate fetching issues from an API or database
    List<String> response = ["NATIVE_TUTOR"];
    // await Future.delayed(Duration(seconds: 1));
    List<Issue> issues = response.map((code) => Issue.fromCode(code)).toList();
    return issues;
  }

  @override
  Future<List<Issue>> loadIssues({required Teacher teacher}) async {
    // Simulate loading issues from local storage
    // final ApiService _apiService = ApiService();
    List<String> response = ["NATIVE_TUTOR"];
    // await Future.delayed(Duration(seconds: 1));
    List<Issue> issues = response.map((code) => Issue.fromCode(code)).toList();
    return issues;
  }

  @override
  Future<List<Issue>> checkMechIssues({required Teacher teacher}) async {
    List<Issue> issues = [];
    final checks = <Issue?>[
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
  Future<List<Issue>> fetchAllIssues({required Teacher teacher}) {
    // Combine AI and mechanical issues
    return Future.wait([
      fetchAiIssues(teacher: teacher),
      checkMechIssues(teacher: teacher)
    ]).then((lists) => lists.expand((list) => list).toList());
  }
}
