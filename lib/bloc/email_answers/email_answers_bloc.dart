// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tutor_letter_gen/bloc/email_answers/email_answers_event.dart';
// import 'package:tutor_letter_gen/bloc/email_answers/email_answers_repository.dart';
// import 'package:tutor_letter_gen/bloc/email_answers/email_answers_state.dart';
// import 'package:tutor_letter_gen/models/email_answer.dart';
// import '/models/status.dart';
// import '/services/sp/sp_services.dart';

// class EmailAnswersBloc extends Bloc<EmailAnswersEvent, EmailAnswersState> {
//   EmailAnswersBloc()
//       : super(EmailAnswersState(
//             status: Status.download,
//             canUpdate: false,
//             fetchedEmailAnswers: '',
//             emailAnswers: [],
//             filteredEmailAnswers: [])) {
//     on<FetchLocalEmailAnswers>(_onFetch);
//     on<UpdateEmailAnswers>(_onUpdate);
//     on<FilterEmailAnswers>(_onFilter);
//   }
//   EmailAnswersRepository emailAnswersRepository = EmailAnswersRepository();

//   FutureOr<void> _onFetch(
//       FetchLocalEmailAnswers event, Emitter<EmailAnswersState> emit) async {
//     emit(state.copyWith(status: Status.download));
//     String localAnswers = await SP.getEmailAnswers();
//     String sheetsAnswers = '';

//     if (localAnswers.isEmpty) {
//       try {
//         sheetsAnswers = await emailAnswersRepository.fetchSheetsEmaisAnswer();
//         List<EmailAnswer> newAnswers =
//             emailAnswersRepository.decodeEmailAnswers(sheetsAnswers);
//         SP.setEmailAnswers(sheetsAnswers);
//         emit(state.copyWith(
//           status: Status.loaded,
//           emailAnswers: newAnswers,
//           filteredEmailAnswers: newAnswers,
//         ));
//       } catch (e) {
//         emit(state.copyWith(status: Status.error));
//       }
//     } else {
//       List<EmailAnswer> newAnswers =
//           emailAnswersRepository.decodeEmailAnswers(localAnswers);
//       emit(state.copyWith(
//         status: Status.loaded,
//         emailAnswers: newAnswers,
//         filteredEmailAnswers: newAnswers,
//       ));
//       try {
//         sheetsAnswers = await emailAnswersRepository.fetchSheetsEmaisAnswer();
//         if (localAnswers != sheetsAnswers && sheetsAnswers.isNotEmpty) {
//           emit(state.copyWith(
//               status: Status.loaded,
//               fetchedEmailAnswers: sheetsAnswers,
//               canUpdate: true));
//         }
//       } catch (e) {
//         //
//       }
//     }
//   }

//   FutureOr<void> _onUpdate(
//       UpdateEmailAnswers event, Emitter<EmailAnswersState> emit) async {
//     List<EmailAnswer> newAnswers =
//         emailAnswersRepository.decodeEmailAnswers(state.fetchedEmailAnswers);
//     SP.setEmailAnswers(state.fetchedEmailAnswers);
//     emit(state.copyWith(
//         status: Status.loaded,
//         emailAnswers: newAnswers,
//         filteredEmailAnswers: newAnswers,
//         canUpdate: false));
//   }

//   FutureOr<void> _onFilter(
//       FilterEmailAnswers event, Emitter<EmailAnswersState> emit) {
//     if (event.filter.isNotEmpty) {
//       List<EmailAnswer> filteredAnswers = state.emailAnswers
//           .where(
//               (element) => element.reason.toLowerCase().contains(event.filter))
//           .toList();
//       emit(state.copyWith(filteredEmailAnswers: filteredAnswers));
//     } else {
//       emit(state.copyWith(filteredEmailAnswers: state.emailAnswers));
//     }
//   }
// }
