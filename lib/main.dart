import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/criterias/criterias_bloc_repository.dart';

import 'package:tutor_letter_gen/bloc/issues/issues_bloc.dart';
import 'package:tutor_letter_gen/bloc/issues/issues_repository.dart';
import 'package:tutor_letter_gen/bloc/letter/letter_bloc.dart';
import 'package:tutor_letter_gen/bloc/criterias/criterias_bloc.dart';
import 'package:tutor_letter_gen/bloc/criterias/criterias_event.dart';
import 'package:tutor_letter_gen/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final CriteriasRepository criteriasRepository = CriteriasRepository();
    final IssuesRepository issuesRepository = IssuesRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CriteriasBloc>(
          lazy: false,
          create: (context) =>
              CriteriasBloc(criteriasRepository: criteriasRepository)
                ..add(FetchLocalCriterias()),
        ),
        BlocProvider<LetterBloc>(
          lazy: false,
          create: (context) => LetterBloc(
              criteriasRepository: criteriasRepository,
              issuesRepository: issuesRepository),
        ),
        BlocProvider<TutorIssuesBloc>(
          lazy: false,
          create: (context) => TutorIssuesBloc(
              issuesRepository: issuesRepository,
              criteriasRepository: criteriasRepository),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appRouter.config(),
      ),
    );
  }
}
