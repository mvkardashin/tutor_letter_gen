import 'package:flutter/material.dart';
import 'package:tutor_letter_gen/models/issue.dart';

class IssueCard extends StatelessWidget {
  final Issue issue;

  const IssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: issue.isWarning ? Colors.yellow[50] : Colors.red[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: issue.isWarning ? Colors.orange : Colors.red,
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
                  issue.isWarning ? Icons.warning_amber : Icons.error,
                  color: issue.isWarning ? Colors.orange : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  issue.code,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: issue.isWarning ? Colors.orange : Colors.red,
                      ),
                ),
                if (issue.excelId != null) ...[
                  const Spacer(),
                  Text(
                    "#${issue.excelId}",
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

            if (issue.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                issue.description,
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
