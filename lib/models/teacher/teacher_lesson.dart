// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'dart:convert';

class TeacherLesson {
  int place;
  int age;
  int size;
  int duration;
  int cost;
  TeacherLesson({
    required this.place,
    required this.age,
    required this.size,
    required this.duration,
    required this.cost,
  });

  TeacherLesson copyWith({
    int? place,
    int? age,
    int? size,
    int? duration,
    int? cost,
  }) {
    return TeacherLesson(
      place: place ?? this.place,
      age: age ?? this.age,
      size: size ?? this.size,
      duration: duration ?? this.duration,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'place': place,
      'age': age,
      'size': size,
      'duration': duration,
      'cost': cost,
    };
  }

  factory TeacherLesson.fromMap(Map<String, dynamic> map) {
    return TeacherLesson(
      place: map['place']?['id']?.toInt() ?? 0,
      age: map['age']?['id']?.toInt() ?? 0,
      size: map['size']?['id']?.toInt() ?? 0,
      duration: map['duration']?['id']?.toInt() ?? 0,
      cost: map['cost']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherLesson.fromJson(String source) =>
      TeacherLesson.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherLesson(place: $place, age: $age, size: $size, duration: $duration, cost: $cost)\n';
  }

  @override
  bool operator ==(covariant TeacherLesson other) {
    if (identical(this, other)) return true;

    return other.place == place &&
        other.age == age &&
        other.size == size &&
        other.duration == duration &&
        other.cost == cost;
  }

  @override
  int get hashCode {
    return place.hashCode ^
        age.hashCode ^
        size.hashCode ^
        duration.hashCode ^
        cost.hashCode;
  }
}
