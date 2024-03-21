import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/criteria.dart';
import '/bloc/criterias/criterias_bloc_repository.dart';
import '/bloc/criterias/criterias_event.dart';
import '/bloc/criterias/criterias_state.dart';

import '/models/criterias.dart';
import '/models/status.dart';
import '/services/sp/sp_services.dart';

class CriteriasBloc extends Bloc<CriteriasEvent, CriteriasState> {
  CriteriasBloc()
      : super(CriteriasState(
            status: Status.download,
            canUpdate: false,
            fetchedCriterias: '',
            criterias: Criterias(errors: [], recs: []),
            filteredCriterias: Criterias(errors: [], recs: []))) {
    on<FetchLocalCriterias>(_onFetch);
    on<UpdateCriterias>(_onUpdate);
    on<FilterCriterias>(_onFilter);
  }
  CriteriasRepository criteriasRepository = CriteriasRepository();

  FutureOr<void> _onFetch(
      FetchLocalCriterias event, Emitter<CriteriasState> emit) async {
    emit(state.copyWith(status: Status.download));
    String localCriterias = await criteriasRepository.fetchLocalCriterias();
    String sheetsCriterias = '';

    if (localCriterias.isEmpty) {
      try {
        sheetsCriterias = await criteriasRepository.fetchSheetsCriterias();
        Criterias newCriterias =
            criteriasRepository.decodeCriterias(sheetsCriterias);
        SP.setCriterias(sheetsCriterias);
        emit(state.copyWith(
            status: Status.loaded,
            criterias: newCriterias,
            filteredCriterias: newCriterias));
      } catch (e) {
        emit(state.copyWith(status: Status.error));
      }
    } else {
      Criterias newCriterias =
          criteriasRepository.decodeCriterias(localCriterias);
      emit(state.copyWith(
          status: Status.loaded,
          criterias: newCriterias,
          filteredCriterias: newCriterias));
      try {
        sheetsCriterias = await criteriasRepository.fetchSheetsCriterias();
        if (localCriterias != sheetsCriterias && sheetsCriterias.isNotEmpty) {
          emit(state.copyWith(
              status: Status.loaded,
              fetchedCriterias: sheetsCriterias,
              canUpdate: true));
        }
      } catch (e) {
        //
      }
    }
  }

  FutureOr<void> _onUpdate(
      UpdateCriterias event, Emitter<CriteriasState> emit) async {
    Criterias newCriterias =
        criteriasRepository.decodeCriterias(state.fetchedCriterias);
    SP.setCriterias(state.fetchedCriterias);
    emit(state.copyWith(
        status: Status.loaded,
        criterias: newCriterias,
        filteredCriterias: newCriterias,
        canUpdate: false));
  }

  FutureOr<void> _onFilter(
      FilterCriterias event, Emitter<CriteriasState> emit) {
    if (event.filter.isNotEmpty) {
      List<Criteria> errs = state.criterias.errors
          .where(
              (element) => element.reason.toLowerCase().contains(event.filter))
          .toList();
      List<Criteria> recs = state.criterias.recs
          .where(
              (element) => element.reason.toLowerCase().contains(event.filter))
          .toList();
      emit(state.copyWith(
          filteredCriterias: Criterias(errors: errs, recs: recs)));
    } else {
      emit(state.copyWith(
          filteredCriterias: Criterias(
              errors: state.criterias.errors, recs: state.criterias.recs)));
    }
  }
}
