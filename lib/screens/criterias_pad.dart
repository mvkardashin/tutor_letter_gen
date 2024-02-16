import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/criterias/criterias_bloc.dart';

import 'package:tutor_letter_gen/bloc/criterias/criterias_state.dart';
import 'package:tutor_letter_gen/components/criterias_list.dart';
import 'package:tutor_letter_gen/models/status.dart';

class CriteriasPad extends StatelessWidget {
  const CriteriasPad({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CriteriasBloc, CriteriasState>(
        builder: (context, state) {
      return switch (state.status) {
        Status.download => CircularProgressIndicator.adaptive(),
        Status.loaded => CriteriasList(),
        Status.error => Text('Ошибка'),
      };
    });
  }
}
