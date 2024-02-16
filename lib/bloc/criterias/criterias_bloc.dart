import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
            criterias: Criterias(errors: [], recs: []))) {
    on<FetchLocalCriterias>(_onFetch);
    on<UpdateCriterias>(_onUpdate);
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
        emit(state.copyWith(status: Status.loaded, criterias: newCriterias));
      } catch (e) {
        emit(state.copyWith(status: Status.error));
      }
    } else {
      Criterias newCriterias =
          criteriasRepository.decodeCriterias(localCriterias);
      emit(state.copyWith(status: Status.loaded, criterias: newCriterias));
      try {
        sheetsCriterias = await criteriasRepository.fetchSheetsCriterias();
        if (localCriterias != sheetsCriterias && sheetsCriterias.isNotEmpty) {
          emit(state.copyWith(
              status: Status.loaded,
              fetchedCriterias: sheetsCriterias,
              canUpdate: true));
        }
      } catch (e) {}
    }
  }

  FutureOr<void> _onUpdate(
      UpdateCriterias event, Emitter<CriteriasState> emit) async {
    Criterias newCriterias =
        criteriasRepository.decodeCriterias(state.fetchedCriterias);
    SP.setCriterias(state.fetchedCriterias);
    emit(state.copyWith(
        status: Status.loaded, criterias: newCriterias, canUpdate: false));
  }
}
