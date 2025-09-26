// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:tutor_letter_gen/data/aiIssues.dart';
import 'package:tutor_letter_gen/data/ai_issues.dart';

class Issue {
  final String code;

  final int? excelId; // nullable
  final String prompt;
  final String description = '';
  final bool isWarning;

  Issue({
    required this.code,
    this.excelId,
    required this.prompt,
    required this.isWarning,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      code: json['code'] as String,
      excelId: json['excel_id'] as int?,
      isWarning: json['is_warning'] as bool,
      prompt: json['prompt'] as String,
    );
  }

  factory Issue.fromCode(String code) {
    final Issue issue = aiIssues.firstWhere(
      (element) => element.code == code,
      orElse: () => throw Exception('Issue with code $code not found'),
    );
    return issue;
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'excel_id': excelId,
      'is_warning': isWarning,
      'prompt': prompt,
    };
  }

  @override
  String toString() {
    return 'Issue(code: $code, excelId: $excelId, prompt: $prompt, isWarning: $isWarning)';
  }
}
