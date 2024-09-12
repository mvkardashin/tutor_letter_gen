import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tutor_letter_gen/models/criteria.dart';
import 'dart:convert';

import 'package:tutor_letter_gen/models/criterias.dart';
import 'package:tutor_letter_gen/models/email_answer.dart';

abstract class SheetsAPI {
  static Future<Criterias> fetchErrorsAndRecs() async {
    Criterias base = Criterias(errors: [], recs: []);
    try {
      Response response = await http.get(Uri.parse(
          'https://script.google.com/macros/s/AKfycbwzHr_6-RczEzRFS_p0mZi0xEnxcgPAp0bLnzAekN12UB34Agkzq7bfj8Xpm-JQERuysQ/exec'));
      // https: //script.google.com/macros/s/AKfycbwzHr_6-RczEzRFS_p0mZi0xEnxcgPAp0bLnzAekN12UB34Agkzq7bfj8Xpm-JQERuysQ/exec
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Criteria> errors =
            data[0].map<Criteria>((e) => Criteria.error(e)).toList();
        List<Criteria> recs =
            data[1].map<Criteria>((e) => Criteria.rec(e)).toList();
        base = base.copyWith(errors: errors, recs: recs);
      }
    } catch (e) {
      base = Criterias(errors: [], recs: []);
    }

    return base;
  }

  static Future<String> fetchCriteriasString() async {
    String resp = '';
    try {
      Response response = await http.get(Uri.parse(
          'https://script.google.com/macros/s/AKfycbwzHr_6-RczEzRFS_p0mZi0xEnxcgPAp0bLnzAekN12UB34Agkzq7bfj8Xpm-JQERuysQ/exec'));

      if (response.statusCode == 200) {
        resp = response.body;
      }
    } catch (e) {
      resp = '';
    }
    return resp;
  }

  static Future<List<EmailAnswer>> fetchEmailAnswers() async {
    List<EmailAnswer> base = [];
    try {
      Response response = await http.get(Uri.parse(
          'https://script.google.com/macros/s/AKfycbxDLjQk4FBJpOsbB9X7bJL5aSj5NRg5nSjHtkTe1vB6WljB5GZKEVlPyTO07Bf32ras7A/exec'));
      // https: //script.google.com/macros/s/AKfycbwzHr_6-RczEzRFS_p0mZi0xEnxcgPAp0bLnzAekN12UB34Agkzq7bfj8Xpm-JQERuysQ/exec
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<EmailAnswer> answers =
            data.map<EmailAnswer>((e) => EmailAnswer.fromMap(e)).toList();

        base = answers;
      }
    } catch (e) {
      base = [];
    }

    return base;
  }

  static Future<String> fetchEmailsAnswersString() async {
    String resp = '';
    try {
      Response response = await http.get(Uri.parse(
          'https://script.google.com/macros/s/AKfycbxDLjQk4FBJpOsbB9X7bJL5aSj5NRg5nSjHtkTe1vB6WljB5GZKEVlPyTO07Bf32ras7A/exec'));

      if (response.statusCode == 200) {
        resp = response.body;
      }
    } catch (e) {
      resp = '';
    }
    return resp;
  }
}
