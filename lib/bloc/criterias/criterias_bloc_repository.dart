import 'dart:async';
import 'dart:convert';
import 'package:tutor_letter_gen/models/criteria.dart';
import '../../services/sheets_api.dart';

class CriteriasRepository {
  List<Criteria> criterias = List.empty(growable: true);

  Future<void> getSheetsCriterias() async {
    final String json = await SheetsAPI.fetchCriteriasString();
    final List<dynamic> data = jsonDecode(json);
    final List<Criteria> criterias =
        data.map<Criteria>((item) => Criteria.fromMap(item)).toList();
    this.criterias = criterias;
  }

  List<Criteria> criteriasForIssues(List<String> issues) {
    return criterias.where((c) => issues.contains(c.code)).toList();
  }

  String get aiErrors => criterias
      .where((cr) => cr.checkType == CheckType.ai)
      .map((e) => '{prompt: ${e.prompt}, code: ${e.code}}')
      .join('\n');

  List<Criteria> get nativeBatchCriterias => criterias
      .where((c) => c.batch == Batch.native && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get badBatchCriterias => criterias
      .where((c) => c.batch == Batch.bad && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get actionBatchCriterias => criterias
      .where((c) => c.batch == Batch.action && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get noneBatchCriterias => criterias
      .where((c) => c.batch == Batch.none && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get personalBatchCriterias => criterias
      .where((c) => c.batch == Batch.personal && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get priceBatchCriterias => criterias
      .where((c) => c.batch == Batch.price && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get timeBatchCriterias => criterias
      .where((c) => c.batch == Batch.time && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get aboutBatchCriterias => criterias
      .where((c) => c.batch == Batch.about && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get groupBatchCriterias => criterias
      .where((c) => c.batch == Batch.group && c.checkType == CheckType.ai)
      .toList();
  List<Criteria> get educationAndOtherBatchCriterias => criterias
      .where((c) =>
          c.batch == Batch.educationAndOther && c.checkType == CheckType.ai)
      .toList();
}
