// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/bloc/email_answers/email_answers_bloc.dart';
// import '/bloc/email_answers/email_answers_state.dart';
// import '/components/email_answers_list.dart';
// import '/models/status.dart';

// class EmailAnswersPad extends StatelessWidget {
//   const EmailAnswersPad({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EmailAnswersBloc, EmailAnswersState>(
//         builder: (context, state) {
//       return switch (state.status) {
//         Status.download => const CircularProgressIndicator.adaptive(),
//         Status.loaded => const EmailAnswersList(),
//         Status.error => const Text('Ошибка'),
//         Status.checkUpdate => const CircularProgressIndicator.adaptive(),
//       };
//     });
//   }
// }
