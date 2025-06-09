import 'package:flutter/material.dart';
import '../models/plant_ai_models.dart';

class PlantInformationWidget extends StatelessWidget {
  final GetPlantInfoOutput? info;

  const PlantInformationWidget({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    if (info == null) return const SizedBox.shrink();

    if (info!.error != null) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.error, color: Colors.red, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  info!.error!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (!info!.isPlant) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: const [
              Icon(Icons.info, color: Colors.blue, size: 28),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The AI could not identify a plant in the provided image.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.eco, color: Colors.green, size: 28),
                const SizedBox(width: 8),
                Text(
                  info!.commonName ?? 'Plant Information',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (info!.latinName != null) ...[
              const SizedBox(height: 4),
              Text(
                info!.latinName!,
                style: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 16),
            if (info!.plantDescription != null) ...[
              Row(
                children: const [
                  Icon(Icons.book, color: Colors.brown),
                  SizedBox(width: 8),
                  Text(
                    'About this Plant',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(info!.plantDescription!),
              const SizedBox(height: 16),
            ],
            if (info!.careTips != null) ...[
              Row(
                children: const [
                  Icon(Icons.lightbulb, color: Colors.amber),
                  SizedBox(width: 8),
                  Text(
                    'Care Tips',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildCareTipRow(Icons.wb_sunny, 'Sunlight', info!.careTips!.sunlight),
              _buildCareTipRow(Icons.opacity, 'Water', info!.careTips!.water),
              _buildCareTipRow(Icons.park, 'Soil', info!.careTips!.soil),
              _buildCareTipRow(Icons.grass, 'Fertilizer', info!.careTips!.fertilizer),
              _buildCareTipRow(Icons.air, 'Humidity', info!.careTips!.humidity),
              _buildCareTipRow(Icons.content_cut, 'Pruning', info!.careTips!.pruning),
              const SizedBox(height: 16),
            ],
            if (info!.funFacts != null && info!.funFacts!.isNotEmpty) ...[
              Row(
                children: const [
                  Icon(Icons.auto_awesome, color: Colors.purple),
                  SizedBox(width: 8),
                  Text(
                    'Fun Facts!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...info!.funFacts!.map((fact) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.star, size: 16),
                        const SizedBox(width: 6),
                        Expanded(child: Text(fact)),
                      ],
                    ),
                  )),
            ],
            if (info!.plantDescription == null &&
                info!.careTips == null &&
                (info!.funFacts == null || info!.funFacts!.isEmpty)) ...[
              const SizedBox(height: 16),
              Row(
                children: const [
                  Icon(Icons.info_outline, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'We found the plant, but detailed information is currently unavailable.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCareTipRow(IconData icon, String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
