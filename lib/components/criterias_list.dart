import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/letter/letter_bloc.dart';
import 'package:tutor_letter_gen/bloc/letter/letter_event.dart';

import '../bloc/criterias/criterias_state.dart';
import '/bloc/criterias/criterias_bloc.dart';
import '/components/criteria_component.dart';

class CriteriasList extends StatelessWidget {
  const CriteriasList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CriteriasBloc, CriteriasState>(
        builder: (context, state) {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ошибки',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ...state.criterias.errors
                .map((e) => CriteriaComponent(
                      element: e,
                      list: context.watch<LetterBloc>().state.errors,
                      onAdd: () {
                        context
                            .read<LetterBloc>()
                            .add(AddInLetter(criteria: e));
                      },
                      onDelete: () {
                        context
                            .read<LetterBloc>()
                            .add(DeleteFromLetter(criteria: e));
                      },
                    ))
                .toList(),
            Text(
              'Рекомендации',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ...state.criterias.recs
                .map((e) => CriteriaComponent(
                      element: e,
                      list: context.watch<LetterBloc>().state.recommendation,
                      onAdd: () {
                        context
                            .read<LetterBloc>()
                            .add(AddInLetter(criteria: e));
                      },
                      onDelete: () {
                        context
                            .read<LetterBloc>()
                            .add(DeleteFromLetter(criteria: e));
                      },
                    ))
                .toList(),
          ],
        ),
      );
    });
  }
}
