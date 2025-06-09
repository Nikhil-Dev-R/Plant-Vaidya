import 'package:flutter/material.dart';
import '../models/plant_ai_models.dart';

class AnalysisResultWidget extends StatelessWidget {
  final AnalyzePlantDiseaseOutput? result;

  const AnalysisResultWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    if (result == null) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.eco, color: Colors.green, size: 30),
                SizedBox(width: 10),
                Text(
                  'Analysis Results',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Here's what our AI found about your plant.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            if (result!.diseaseDetected) ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Disease Detected: ${result!.diseaseName.isNotEmpty ? result!.diseaseName : "Unknown Disease"}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Your plant may be affected. See suggestions below.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ] else ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'No Disease Detected',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Your plant appears to be healthy based on the analysis.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ],
            const SizedBox(height: 20),
            if (result!.suggestedSolutions.isNotEmpty) ...[
              Row(
                children: const [
                  Icon(Icons.list_alt, color: Colors.blue, size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Suggested Actions:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: result!.suggestedSolutions
                      .map((solution) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.check, size: 18, color: Colors.blueAccent),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: Text(
                                  solution,
                                  style: const TextStyle(fontSize: 16),
                                )),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ] else if (!result!.diseaseDetected) ...[
              const Text(
                'Keep up the good work with your plant care!',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ] else ...[
              const Text(
                'No specific solutions were suggested for the detected issue. Consider general plant care or consulting a local expert.',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
