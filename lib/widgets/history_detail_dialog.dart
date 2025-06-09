
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_vaidya/models/plant_models.dart';

class HistoryDetailDialog extends StatelessWidget {
  final HistoryEntry entry;

  const HistoryDetailDialog({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat("MMMM d, yyyy 'at' h:mm a").format(entry.date);
    final imageBytes = base64Decode(entry.imageDataUri.split(',').last);

    return AlertDialog(
      title: Text(entry.originalImageName ?? "Analysis Details"),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      content: SizedBox(
        width: double.maxFinite, // Use as much width as possible
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(formattedDate, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16),
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.memory(
                    imageBytes,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (entry.description != null && entry.description!.isNotEmpty) ...[
                Text('Description Provided:', style: Theme.of(context).textTheme.titleSmall),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 4, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(entry.description!),
                ),
              ],
              
              Card(
                color: entry.diseaseDetected ? Colors.red[50] : Colors.green[50],
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    entry.diseaseDetected ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                    color: entry.diseaseDetected ? Colors.red[700] : Colors.green[700],
                  ),
                  title: Text(
                    entry.diseaseDetected ? 'Disease: ${entry.diseaseName}' : 'Result: ${entry.diseaseName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                       color: entry.diseaseDetected ? Colors.red[800] : Colors.green[800],
                    ),
                  ),
                ),
              ),

              if (entry.suggestedSolutions.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Suggested Solutions:', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer.withAlpha((0.2 * 255).round()),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: entry.suggestedSolutions
                        .map((solution) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.chevron_right, size: 18, color: Theme.of(context).colorScheme.primary),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text(solution)),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ] else ...[
                const SizedBox(height: 16),
                Text('No specific solutions were provided in this analysis.', style: Theme.of(context).textTheme.bodySmall),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
