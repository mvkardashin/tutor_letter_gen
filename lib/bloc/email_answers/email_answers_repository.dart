import 'dart:convert';

import 'package:tutor_letter_gen/models/email_answer.dart';
import 'package:tutor_letter_gen/services/sp/sp_services.dart';

import '../../services/sheets_api.dart';

class EmailAnswersRepository {
  Future<String> fetchLocalEmailAnswers() async {
    String emailAnswers = await SP.getEmailAnswers();
    return emailAnswers;
  }

  Future<String> fetchSheetsEmaisAnswer() async {
    String answers = await SheetsAPI.fetchEmailsAnswersString();
    return answers;
  }

  List<EmailAnswer> decodeEmailAnswers(String fetchedcrit) {
    List<dynamic> data = jsonDecode(fetchedcrit);

    List<EmailAnswer> answers =
        data.map<EmailAnswer>((e) => EmailAnswer.fromMap(e)).toList();

    return answers;
  }
}
