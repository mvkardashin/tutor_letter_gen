import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/services/api_service.dart';
import '/bloc/criterias/criterias_bloc.dart';
import '/bloc/issues/issues_bloc.dart';
import '/bloc/issues/issues_event.dart';
import '/bloc/letter/letter_bloc.dart';
import '/bloc/letter/letter_event.dart';
import '/models/issue.dart';
import '/models/teacher/teacher.dart';
import '/models/teacher/teacherAI.dart';
import '/screens/issue_card.dart';
import '/screens/teacher_ai_details.dart';

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
    context.read<TutorIssuesBloc>().add(FetchIssues(
          teacher: teacher!,
        ));
  }

  void _onPressCheckAI() {
    ApiService().fetchAiIssues(
        errorPrompt: context.read<CriteriasBloc>().state.aiErrors,
        teacherJson: teacherAI.toString());
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
            context.read<LetterBloc>().add(AddinLetterFromIssues());
            context.tabsRouter.setActiveIndex(1);
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
                ),
                ElevatedButton(
                    onPressed: _onPressCheck,
                    child: const Text('Проверить анкету')),
                ElevatedButton(
                    onPressed: _onPressCheckAI,
                    child: const Text('Проверить AI анкету')),
                ...context
                    .read<CriteriasBloc>()
                    .state
                    .criteriasForIssues(
                        context.watch<TutorIssuesBloc>().state.issues)
                    .map((el) => IssueCard(issue: el)),
                Text(context.watch<CriteriasBloc>().state.aiErrors),
              ],
            ),
          ),
        ),
      );
    }
  }
}
