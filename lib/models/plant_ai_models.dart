class AnalyzePlantDiseaseInput {
  final String photoDataUri;
  final String description;

  AnalyzePlantDiseaseInput({
    required this.photoDataUri,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'photoDataUri': photoDataUri,
        'description': description,
      };
}

class AnalyzePlantDiseaseOutput {
  final bool diseaseDetected;
  final String diseaseName;
  final List<String> suggestedSolutions;
  final double? confidenceScore;
  final List<String>? possibleCauses;

  AnalyzePlantDiseaseOutput({
    required this.diseaseDetected,
    required this.diseaseName,
    required this.suggestedSolutions,
    this.confidenceScore,
    this.possibleCauses,
  });

  factory AnalyzePlantDiseaseOutput.fromJson(Map<String, dynamic> json) {
    return AnalyzePlantDiseaseOutput(
      diseaseDetected: json['diseaseDetected'] as bool,
      diseaseName: json['diseaseName'] as String,
      suggestedSolutions: List<String>.from(json['suggestedSolutions'] ?? []),
      confidenceScore: (json['confidenceScore'] != null) ? (json['confidenceScore'] as num).toDouble() : null,
      possibleCauses: json['possibleCauses'] != null ? List<String>.from(json['possibleCauses']) : null,
    );
  }
}

class GetPlantInfoInput {
  final String photoDataUri;
  final String? description;

  GetPlantInfoInput({
    required this.photoDataUri,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'photoDataUri': photoDataUri,
        if (description != null) 'description': description,
      };
}

class PlantCareTips {
  final String? sunlight;
  final String? water;
  final String? soil;
  final String? fertilizer;
  final String? humidity;
  final String? pruning;

  PlantCareTips({
    this.sunlight,
    this.water,
    this.soil,
    this.fertilizer,
    this.humidity,
    this.pruning,
  });

  factory PlantCareTips.fromJson(Map<String, dynamic> json) {
    return PlantCareTips(
      sunlight: json['sunlight'] as String?,
      water: json['water'] as String?,
      soil: json['soil'] as String?,
      fertilizer: json['fertilizer'] as String?,
      humidity: json['humidity'] as String?,
      pruning: json['pruning'] as String?,
    );
  }
}

class GetPlantInfoOutput {
  final bool isPlant;
  final String? commonName;
  final String? latinName;
  final String? plantDescription;
  final PlantCareTips? careTips;
  final List<String>? funFacts;
  final String? error;

  GetPlantInfoOutput({
    required this.isPlant,
    this.commonName,
    this.latinName,
    this.plantDescription,
    this.careTips,
    this.funFacts,
    this.error,
  });

  factory GetPlantInfoOutput.fromJson(Map<String, dynamic> json) {
    return GetPlantInfoOutput(
      isPlant: json['isPlant'] as bool,
      commonName: json['commonName'] as String?,
      latinName: json['latinName'] as String?,
      plantDescription: json['plantDescription'] as String?,
      careTips: json['careTips'] != null ? PlantCareTips.fromJson(json['careTips']) : null,
      funFacts: json['funFacts'] != null ? List<String>.from(json['funFacts']) : null,
      error: json['error'] as String?,
    );
  }
}

class ReasonAboutPlantSuggestionsInput {
  final String plantCondition;
  final List<String> allSuggestions;

  ReasonAboutPlantSuggestionsInput({
    required this.plantCondition,
    required this.allSuggestions,
  });

  Map<String, dynamic> toJson() => {
        'plantCondition': plantCondition,
        'allSuggestions': allSuggestions,
      };
}

typedef ReasonAboutPlantSuggestionsOutput = List<String>;
