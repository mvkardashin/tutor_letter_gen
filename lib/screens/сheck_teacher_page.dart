import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/criterias/criterias_bloc.dart';
import 'package:tutor_letter_gen/bloc/issues/issues_bloc.dart';
import 'package:tutor_letter_gen/bloc/issues/issues_event.dart';
import 'package:tutor_letter_gen/bloc/letter/letter_bloc.dart';
import 'package:tutor_letter_gen/bloc/letter/letter_event.dart';
import 'package:tutor_letter_gen/models/issue.dart';
import 'package:tutor_letter_gen/models/teacher/teacher.dart';
import 'package:tutor_letter_gen/models/teacher/teacherAI.dart';
import 'package:tutor_letter_gen/screens/issue_card.dart';
import 'package:tutor_letter_gen/screens/teacher_ai_details.dart';

@RoutePage()
class CheckTeacherPage extends StatefulWidget {
  const CheckTeacherPage({super.key});

  @override
  State<CheckTeacherPage> createState() => _CheckTeacherPageState();
}

class _CheckTeacherPageState extends State<CheckTeacherPage> {
  List<Issue> issues = [];
  Teacher? teacher;
  TeacherAI? teacherAI;
  @override
  void initState() {
    initTeacher();
    super.initState();
  }

  void initTeacher() async {
    final jsonString = await rootBundle.loadString('teachers2.json');
    teacher = Teacher.fromJSON(jsonDecode(jsonString) as Map<String, dynamic>);
    teacherAI = TeacherAI.fromTeacher(teacher!);
    setState(() {});
  }

  void _onPressCheck() {
    context.read<IssuesBloc>().add(FetchIssues(teacher: teacher!));
  }

  @override
  Widget build(BuildContext context) {
    if (teacher == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    } else {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<LetterBloc>().add(AddinLetterFromIssues(
                  issues: context.read<IssuesBloc>().state.issues,
                  errors: context.read<CriteriasBloc>().state.criterias.errors,
                  recommendations:
                      context.read<CriteriasBloc>().state.criterias.recs,
                ));
            // AutoRouter.of(context).pop();
          },
          tooltip: 'Отправить ошибки в письмо',
          label: const Text('Отправить ошибки в письмо'),
          icon: const Icon(Icons.send),
        ),
        appBar: AppBar(
          title: const Text('Проверка анкеты репетитора'),
        ),
        body: SingleChildScrollView(
          child: SelectionArea(
            child: Column(
              children: [
                Center(
                  child: TeacherAIDetails(teacher: teacherAI!),

                  // Text(teacherAI!.toString()),
                ),
                ElevatedButton(
                    onPressed: _onPressCheck,
                    child: const Text('Проверить анкету')),
                ...context
                    .watch<IssuesBloc>()
                    .state
                    .issues
                    .map((e) => IssueCard(issue: e)),
              ],
            ),
          ),
        ),
      );
    }
  }
}
