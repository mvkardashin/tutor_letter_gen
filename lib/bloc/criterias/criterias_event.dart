class CriteriasEvent {}

class FetchLocalCriterias extends CriteriasEvent {}

class UpdateCriterias extends CriteriasEvent {}

class FilterCriterias extends CriteriasEvent {
  final String filter;
  FilterCriterias({
    required this.filter,
  });
}
