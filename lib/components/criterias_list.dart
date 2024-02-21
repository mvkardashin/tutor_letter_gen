import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_letter_gen/bloc/letter/letter_bloc.dart';
import 'package:tutor_letter_gen/bloc/letter/letter_event.dart';

import '../bloc/criterias/criterias_event.dart';
import '../bloc/criterias/criterias_state.dart';
import '/bloc/criterias/criterias_bloc.dart';
import '/components/criteria_component.dart';

class CriteriasList extends StatefulWidget {
  const CriteriasList({super.key});

  @override
  State<CriteriasList> createState() => _CriteriasListState();
}

class _CriteriasListState extends State<CriteriasList> {
  final TextEditingController _editingController = TextEditingController();

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
              'Фильтр',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextFormField(
                controller: _editingController,
                onChanged: (value) {
                  context
                      .read<CriteriasBloc>()
                      .add(FilterCriterias(filter: _editingController.text));
                },
                decoration: const InputDecoration(
                    labelText: 'Поиск по заголовкам причин'),
              ),
            ),
            Text(
              'Ошибки',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ...state.filteredCriterias.errors
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
            ...state.filteredCriterias.recs
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
