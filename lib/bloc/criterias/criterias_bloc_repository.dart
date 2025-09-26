import 'dart:convert';

import 'package:tutor_letter_gen/models/criteria.dart';
import 'package:tutor_letter_gen/models/criterias.dart';
import 'package:tutor_letter_gen/services/sp/sp_services.dart';
import '../../services/sheets_api.dart';

class CriteriasRepository {
  /// Fetches criteria data from local storage
  Future<Criterias> getLocalCriterias() async {
    final String json = await SP.getCriterias();
    return _parseCriterias(json);
  }

  /// Fetches criteria data from Google Sheets API
  Future<Criterias> getSheetsCriterias() async {
    final String json = await SheetsAPI.fetchCriteriasString();
    return _parseCriterias(json);
  }

  /// Parses JSON string into Criterias model
  Criterias _parseCriterias(String json) {
    final List<dynamic> data = jsonDecode(json);

    final List<Criteria> errors =
        data[0].map<Criteria>((item) => Criteria.error(item)).toList();

    final List<Criteria> recommendations =
        data[1].map<Criteria>((item) => Criteria.rec(item)).toList();

    return Criterias(errors: errors, recs: recommendations);
  }

  Future<String> fetchLocalCriterias() async {
    // Get criterias from local storage (SP)
    return ''; // Implement actual local storage fetch
  }

  Future<String> fetchSheetsCriterias() async {
    // Fetch criterias from Google Sheets
    return ''; // Implement actual sheets fetch
  }

  Criterias decodeCriterias(String criteriasJson) {
    // Decode JSON string to Criterias object
    return Criterias(errors: [], recs: []); // Implement actual JSON decoding
  }
}
