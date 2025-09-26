import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tutor_letter_gen/bloc/email_answers/email_answers_bloc.dart';
// import 'package:tutor_letter_gen/bloc/email_answers/email_answers_event.dart';
// import 'package:tutor_letter_gen/bloc/email_letter/email_letter_bloc.dart';
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
        BlocProvider<IssuesBloc>(
          lazy: false,
          create: (context) => IssuesBloc(issuesRepository: IssuesRepository()),
        ),
        // BlocProvider<EmailAnswersBloc>(
        //   lazy: false,
        //   create: (context) =>
        //       EmailAnswersBloc()..add(FetchLocalEmailAnswers()),
        // ),
        // BlocProvider<EmailLetterBloc>(
        //   lazy: false,
        //   create: (context) => EmailLetterBloc(),
        // ),
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
