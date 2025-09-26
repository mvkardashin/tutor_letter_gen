import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/criteria.dart';
import '/bloc/criterias/criterias_bloc_repository.dart';
import '/bloc/criterias/criterias_event.dart';
import '/bloc/criterias/criterias_state.dart';

import '/models/criterias.dart';
import '/models/status.dart';
import '/services/sp/sp_services.dart';

class CriteriasBloc extends Bloc<CriteriasEvent, CriteriasState> {
  final CriteriasRepository _criteriasRepository = CriteriasRepository();

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

  Future<void> _onFetch(
      FetchLocalCriterias event, Emitter<CriteriasState> emit) async {
    emit(state.copyWith(status: Status.download));
    String localCriterias = await _criteriasRepository.fetchLocalCriterias();
    String sheetsCriterias = '';

    if (localCriterias.isEmpty) {
      debugPrint('localCriterias: ${localCriterias.isEmpty}');
      try {
        // sheetsCriterias = await _criteriasRepository.getSheetsCriterias();
        debugPrint('sheetsCriterias: $sheetsCriterias');
        Criterias newCriterias =
            await _criteriasRepository.getSheetsCriterias();
        await SP.setCriterias(sheetsCriterias);
        emit(state.copyWith(
            status: Status.loaded,
            criterias: newCriterias,
            filteredCriterias: newCriterias));
      } catch (e) {
        emit(state.copyWith(status: Status.error));
      }
    } else {
      Criterias newCriterias =
          _criteriasRepository.decodeCriterias(localCriterias);
      emit(state.copyWith(
          status: Status.loaded,
          criterias: newCriterias,
          filteredCriterias: newCriterias));
      try {
        sheetsCriterias = await _criteriasRepository.fetchSheetsCriterias();
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

  Future<void> _onUpdate(
      UpdateCriterias event, Emitter<CriteriasState> emit) async {
    Criterias newCriterias =
        _criteriasRepository.decodeCriterias(state.fetchedCriterias);
    await SP.setCriterias(state.fetchedCriterias);
    emit(state.copyWith(
        status: Status.loaded,
        criterias: newCriterias,
        filteredCriterias: newCriterias,
        canUpdate: false));
  }

  void _onFilter(FilterCriterias event, Emitter<CriteriasState> emit) {
    if (event.filter.isNotEmpty) {
      List<Criteria> errs = state.criterias.errors
          .where((element) =>
              element.reason.toLowerCase().contains(event.filter.toLowerCase()))
          .toList();
      List<Criteria> recs = state.criterias.recs
          .where((element) =>
              element.reason.toLowerCase().contains(event.filter.toLowerCase()))
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
