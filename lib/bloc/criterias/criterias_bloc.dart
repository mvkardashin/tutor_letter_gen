import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/criteria.dart';
import '/bloc/criterias/criterias_bloc_repository.dart';
import '/bloc/criterias/criterias_event.dart';
import '/bloc/criterias/criterias_state.dart';

import '/models/status.dart';

class CriteriasBloc extends Bloc<CriteriasEvent, CriteriasState> {
  final CriteriasRepository criteriasRepository;

  CriteriasBloc({required this.criteriasRepository})
      : super(CriteriasState(
            status: Status.download,
            canUpdate: false,
            fetchedCriterias: '',
            criterias: [],
            filteredCriterias: [])) {
    on<FetchLocalCriterias>(_onFetch);
    on<FilterCriterias>(_onFilter);
  }

  Future<void> _onFetch(
      FetchLocalCriterias event, Emitter<CriteriasState> emit) async {
    emit(state.copyWith(status: Status.download));
    try {
      await criteriasRepository.getSheetsCriterias();

      // await SP.setCriterias(sheetsCriterias);
      emit(state.copyWith(
          status: Status.loaded,
          criterias: criteriasRepository.criterias,
          filteredCriterias: criteriasRepository.criterias));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  // Future<void> _onUpdate(
  //     UpdateCriterias event, Emitter<CriteriasState> emit) async {
  //   List<Criteria> newCriterias =
  //       criteriasRepository.decodeCriterias(state.fetchedCriterias);
  //   await SP.setCriterias(state.fetchedCriterias);
  //   emit(state.copyWith(
  //       status: Status.loaded,
  //       criterias: newCriterias,
  //       filteredCriterias: newCriterias,
  //       canUpdate: false));
  // }

  void _onFilter(FilterCriterias event, Emitter<CriteriasState> emit) {
    if (event.filter.isNotEmpty) {
      List<Criteria> filteredCriterias = state.criterias
          .where((element) =>
              element.reason.toLowerCase().contains(event.filter.toLowerCase()))
          .toList();

      emit(state.copyWith(filteredCriterias: filteredCriterias));
    } else {
      emit(state.copyWith(filteredCriterias: state.criterias));
    }
  }
}
