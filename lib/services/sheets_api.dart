import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tutor_letter_gen/models/criteria.dart';
import 'dart:convert';

String uri =
    'https://script.google.com/macros/s/AKfycbx6ilKKAbc-qCIO8G4QgCsNa098OkwFnLw8OlnzjYVM8HyXNq_FJapX78_B2hl-6QRM/exec';

abstract class SheetsAPI {
  static Future<List<Criteria>> fetchCriterias() async {
    List<Criteria> base = [];
    try {
      Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Criteria> criterias =
            data.map<Criteria>((e) => Criteria.fromMap(e)).toList();

        base = criterias;
      } else {
        base = [];
      }
    } catch (e) {
      base = [];
    }

    return base;
  }

  static Future<String> fetchCriteriasString() async {
    String resp = '';
    try {
      Response response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        resp = response.body;
      } else {
        resp = '[]';
      }
    } catch (e) {
      resp = '[]';
    }
    return resp;
  }
}
