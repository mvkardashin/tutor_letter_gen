// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tutor_letter_gen/bloc/email_letter/email_letter_bloc.dart';
// import 'package:tutor_letter_gen/bloc/email_letter/email_letter_event.dart';
// import '/bloc/email_answers/email_answers_bloc.dart';
// import '/bloc/email_answers/email_answers_event.dart';
// import '/bloc/email_answers/email_answers_state.dart';
// import '/components/email_answer_component.dart';

// class EmailAnswersList extends StatefulWidget {
//   const EmailAnswersList({super.key});

//   @override
//   State<EmailAnswersList> createState() => _EmailAnswersListState();
// }

// class _EmailAnswersListState extends State<EmailAnswersList> {
//   final TextEditingController _editingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EmailAnswersBloc, EmailAnswersState>(
//         builder: (context, state) {
//       return SizedBox(
//           width: MediaQuery.of(context).size.width / 2,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Фильтр',
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         context.read<EmailLetterBloc>().add(CleanEmailLetter());
//                       },
//                       child: const Text('Сбросить'))
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: TextFormField(
//                   controller: _editingController,
//                   onChanged: (value) {
//                     context.read<EmailAnswersBloc>().add(
//                         FilterEmailAnswers(filter: _editingController.text));
//                   },
//                   decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                           tooltip: 'Очистить содержимое',
//                           onPressed: () {
//                             setState(() {
//                               _editingController.text = '';
//                               context.read<EmailAnswersBloc>().add(
//                                   FilterEmailAnswers(
//                                       filter: _editingController.text));
//                             });
//                           },
//                           icon: const Icon(Icons.close)),
//                       labelText: 'Поиск по заголовкам причин'),
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Ответы',
//                         style: Theme.of(context).textTheme.headlineMedium,
//                       ),
//                       ...state.filteredEmailAnswers
//                           .map((e) => EmailAnswerComponent(
//                                 element: e,
//                                 list: context
//                                     .watch<EmailLetterBloc>()
//                                     .state
//                                     .answers,
//                                 onAdd: () {
//                                   context
//                                       .read<EmailLetterBloc>()
//                                       .add(AddInEmailLetter(answer: e));
//                                 },
//                                 onDelete: () {
//                                   context
//                                       .read<EmailLetterBloc>()
//                                       .add(DeleteFromEmailLetter(answer: e));
//                                 },
//                               ))
//                           .toList(),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ));
//     });
//   }
// }
