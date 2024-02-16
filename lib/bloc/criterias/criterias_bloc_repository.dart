import 'dart:convert';

import 'package:tutor_letter_gen/models/criteria.dart';
import 'package:tutor_letter_gen/models/criterias.dart';
import 'package:tutor_letter_gen/services/sp/sp_services.dart';

import '../../services/sheets_api.dart';

class CriteriasRepository {
  Future<String> fetchLocalCriterias() async {
    String criterias = await SP.getCriterias();
    return criterias;
  }

  Future<String> fetchSheetsCriterias() async {
    String criterias = await SheetsAPI.fetchCriteriasString();
    return criterias;
  }

  Criterias decodeCriterias(String fetchedcrit) {
    List<dynamic> data = jsonDecode(fetchedcrit);

    List<Criteria> errors =
        data[0].map<Criteria>((e) => Criteria.error(e)).toList();
    List<Criteria> recs =
        data[1].map<Criteria>((e) => Criteria.rec(e)).toList();

    return Criterias(errors: errors, recs: recs);
  }
}
