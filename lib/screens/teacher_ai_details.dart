import 'package:flutter/material.dart';
import 'package:tutor_letter_gen/models/teacher/teacher_ai.dart';

class TeacherAIDetails extends StatefulWidget {
  final TeacherAI teacher;

  const TeacherAIDetails({super.key, required this.teacher});

  @override
  State<TeacherAIDetails> createState() => _TeacherAIDetailsState();
}

class _TeacherAIDetailsState extends State<TeacherAIDetails> {
  bool expanded = false;

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget buildPhoto(String url, {double size = 100}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey[300],
            child: const Icon(Icons.person, size: 40, color: Colors.grey),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.teacher;

    return Card(
      margin: const EdgeInsets.all(12),
      child: ExpansionTile(
        initiallyExpanded: expanded,
        onExpansionChanged: (val) => setState(() => expanded = val),
        leading: buildPhoto(t.photoSmall, size: 60),
        title: Text(
          t.userFullname,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(t.photoSmall), // URL фотки
        childrenPadding: const EdgeInsets.all(16),
        children: [
          _buildRow("ID", t.id.toString()),
          _buildRow("Репетитор", t.repetitor),
          _buildRow("Фото", t.photoSmall),
          buildPhoto(t.photoSmall, size: 200),
          _buildRow("URL", t.url),
          _buildRow("ФИО", t.userFullname),
          _buildRow("Предмет", t.subject),
          _buildRow("Категории", t.categories.toString()),
          _buildRow("Позиции", t.positions.toString()),
          _buildRow("Цены", t.lessonsPretty),
          _buildRow("Наценки", t.surcharges),
          _buildRow("Время у себя", t.timeLocalPretty),
          _buildRow("Время выезда", t.timeDeparturePretty),
          _buildRow("Время онлайн", t.timeRemotePretty),
          _buildRow("Количество районов у себя", t.areaLocalCount.toString()),
          _buildRow(
              "Количество районов выезда", t.areaDepartureCount.toString()),
          _buildRow("Количество метро у себя", t.metroLocalCount.toString()),
          _buildRow(
              "Количество метро выезда", t.metroDepartureCount.toString()),
          _buildRow("Образование", t.educations.toString()),
          _buildRow("Опыт", t.experience.toString()),
          _buildRow("Степень", t.degree.toString()),
          _buildRow("Звания", t.rank.toString()),
          _buildRow("Награды", t.honor.toString()),
          _buildRow("Повышения", t.advance.toString()),
          _buildRow("О себе", t.text),
          _buildRow("Акции", t.actions.toString()),
          _buildRow("Группы", t.groups.toString()),
        ],
      ),
    );
  }
}
