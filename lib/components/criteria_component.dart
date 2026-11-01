// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tutor_letter_gen/models/criteria.dart';

// ignore: must_be_immutable
class CriteriaComponent extends StatelessWidget {
  final bool isSelected;
  final Criteria element;
  final Function onAdd;
  final Function onDelete;
  const CriteriaComponent({
    super.key,
    required this.element,
    required this.onAdd,
    required this.onDelete,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: isSelected,
        title: Row(
          children: [
            Expanded(child: Text(element.reason)),
            if (element.desc.isNotEmpty)
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((BuildContext context) {
                          return AlertDialog.adaptive(
                            title: Text(element.desc),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Закрыть'))
                            ],
                          );
                        }));
                  },
                  icon: const Icon(Icons.question_mark))
          ],
        ),
        onChanged: (bool? e) {
          e == true ? onAdd() : onDelete();
        });
  }
}
