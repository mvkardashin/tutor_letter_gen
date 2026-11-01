// ignore_for_file: public_member_api_docs, sort_constructors_first
class TeacherSurcharge {
  final int id;
  final int subjectId;
  final double ratio;
  final int cost;

  TeacherSurcharge({
    required this.id,
    required this.subjectId,
    required this.ratio,
    required this.cost,
  });

  factory TeacherSurcharge.fromMap(Map<String, dynamic> map) {
    return TeacherSurcharge(
      id: (map['id'] as num?)?.toInt() ?? 0,
      subjectId: (map['subject_id'] as num?)?.toInt() ?? 0,
      ratio: double.tryParse(map['ratio']?.toString() ?? '1.0') ?? 1.0,
      cost: (map['cost'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'TeacherSurcharge(id: $id, subjectId: $subjectId, ratio: $ratio, cost: $cost)';
  }
}
