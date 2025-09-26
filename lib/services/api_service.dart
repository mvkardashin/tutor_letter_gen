abstract class ApiServiceImpl {
  Future<List<String>> fetchAiIssues();
  Future<List<String>> loadIssue();
}

class ApiService implements ApiServiceImpl {
  @override
  Future<List<String>> fetchAiIssues() async {
    await Future.delayed(const Duration(seconds: 1));
    return ["NATIVE_TUTOR"];
  }

  @override
  Future<List<String>> loadIssue() async {
    await Future.delayed(const Duration(seconds: 1));
    return ["NATIVE_TUTOR"];
  }
}
