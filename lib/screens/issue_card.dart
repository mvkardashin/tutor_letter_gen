import 'package:flutter/material.dart';
import 'package:tutor_letter_gen/models/criteria.dart';
import 'package:tutor_letter_gen/models/criteria_type.dart';

class IssueCard extends StatelessWidget {
  final Criteria issue;

  const IssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: issue.type == CriteriaType.recommendation
          ? Colors.yellow[50]
          : Colors.red[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: issue.type == CriteriaType.recommendation
              ? Colors.orange
              : Colors.red,
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Row(
              children: [
                Icon(
                  issue.type == CriteriaType.recommendation
                      ? Icons.warning_amber
                      : Icons.error,
                  color: issue.type == CriteriaType.recommendation
                      ? Colors.orange
                      : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  issue.code,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: issue.type == CriteriaType.recommendation
                            ? Colors.orange
                            : Colors.red,
                      ),
                ),
                ...[
                  const Spacer(),
                  Text(
                    "#${issue.id}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 12),

            // Prompt
            Text(
              issue.prompt,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            if (issue.reason.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                issue.reason,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
