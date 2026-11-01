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
