
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_vaidya/models/plant_models.dart';

class HistoryListItemWidget extends StatelessWidget {
  final HistoryEntry entry;
  final VoidCallback onTap;

  const HistoryListItemWidget({
    super.key,
    required this.entry,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat("MMMM d, yyyy 'at' h:mm a").format(entry.date);
    final imageBytes = base64Decode(entry.imageDataUri.split(',').last);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.memory(
                imageBytes,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          entry.originalImageName ?? 'Plant Analysis',
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Chip(
                        label: Text(
                          entry.diseaseDetected ? 'Disease Detected' : 'Healthy',
                          style: TextStyle(
                            color: entry.diseaseDetected ? Colors.red[700] : Colors.green[700],
                            fontSize: 10,
                          ),
                        ),
                        backgroundColor: entry.diseaseDetected ? Colors.red[100] : Colors.green[100],
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  if (entry.diseaseDetected)
                    Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, size: 16, color: Colors.orange[700]),
                        const SizedBox(width: 4),
                        Expanded(
                            child: Text(
                            entry.diseaseName.isNotEmpty ? entry.diseaseName : "Unknown Disease",
                            style: TextStyle(color: Colors.orange[800]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  else
                     Row(
                      children: [
                        Icon(Icons.check_circle_outline, size: 16, color: Colors.green[700]),
                        const SizedBox(width: 4),
                        Expanded(
                            child: Text(
                            entry.diseaseName.isNotEmpty ? entry.diseaseName : "No disease detected",
                            style: TextStyle(color: Colors.green[800]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  if (entry.description != null && entry.description!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Description: ${entry.description}',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "View Details",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
