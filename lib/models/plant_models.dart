
import 'package:plant_vaidya/models/plant_ai_models.dart';

class HistoryEntry {
  final String id;
  final DateTime date;
  final String imageDataUri; // Keep as string for simplicity, or use Uint8List if handling raw bytes
  final String? originalImageName;
  final String? description;
  final bool diseaseDetected;
  final String diseaseName;
  final List<String> suggestedSolutions;

  HistoryEntry({
    required this.id,
    required this.date,
    required this.imageDataUri,
    this.originalImageName,
    this.description,
    required this.diseaseDetected,
    required this.diseaseName,
    required this.suggestedSolutions,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      id: json['id'],
      date: DateTime.parse(json['date']),
      imageDataUri: json['imageDataUri'],
      originalImageName: json['originalImageName'],
      description: json['description'],
      diseaseDetected: json['diseaseDetected'],
      diseaseName: json['diseaseName'],
      suggestedSolutions: List<String>.from(json['suggestedSolutions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'imageDataUri': imageDataUri,
      'originalImageName': originalImageName,
      'description': description,
      'diseaseDetected': diseaseDetected,
      'diseaseName': diseaseName,
      'suggestedSolutions': suggestedSolutions,
    };
  }
}

class AnalysisResultData {
  final bool diseaseDetected;
  final String diseaseName;
  final List<String> suggestedSolutions;

  AnalysisResultData({
    required this.diseaseDetected,
    required this.diseaseName,
    required this.suggestedSolutions,
  });

  factory AnalysisResultData.fromJson(Map<String, dynamic> json) {
    return AnalysisResultData(
      diseaseDetected: json['diseaseDetected'] ?? false,
      diseaseName: json['diseaseName'] ?? (json['diseaseDetected'] ? "Unknown Issue" : "Healthy"),
      suggestedSolutions: List<String>.from(json['suggestedSolutions'] ?? []),
    );
  }
}

enum AnalysisAction { disease, info }

class PlantInformation {
  final bool isPlant;
  final String? commonName;
  final String? latinName;
  final String? plantDescription;
  final PlantCareTips? careTips;
  final List<String>? funFacts;
  final String? error;

  PlantInformation({
    required this.isPlant,
    this.commonName,
    this.latinName,
    this.plantDescription,
    this.careTips,
    this.funFacts,
    this.error,
  });

  factory PlantInformation.fromJson(Map<String, dynamic> json) {
    return PlantInformation(
      isPlant: json['isPlant'] ?? false,
      commonName: json['commonName'],
      latinName: json['latinName'],
      plantDescription: json['plantDescription'],
      careTips: json['careTips'] != null ? PlantCareTips.fromJson(json['careTips']) : null,
      funFacts: json['funFacts'] != null ? List<String>.from(json['funFacts']) : [],
      error: json['error'],
    );
  }
}
