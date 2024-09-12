import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/email_answers/email_answers_bloc.dart';
import 'package:tutor_letter_gen/bloc/email_answers/email_answers_event.dart';
import 'package:tutor_letter_gen/bloc/email_letter/email_letter_bloc.dart';

import 'bloc/letter/letter_bloc.dart';

import 'bloc/criterias/criterias_bloc.dart';
import 'bloc/criterias/criterias_event.dart';
import 'router/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CriteriasBloc>(
            lazy: false,
            create: (context) => CriteriasBloc()..add(FetchLocalCriterias()),
          ),
          BlocProvider<LetterBloc>(
            lazy: false,
            create: (context) => LetterBloc(),
          ),
          BlocProvider<EmailAnswersBloc>(
            lazy: false,
            create: (context) =>
                EmailAnswersBloc()..add(FetchLocalEmailAnswers()),
          ),
          BlocProvider<EmailLetterBloc>(
            lazy: false,
            create: (context) => EmailLetterBloc(),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: _appRouter.config(),
        ));
  }
}
