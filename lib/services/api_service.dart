import 'dart:convert';
import 'package:plant_vaidya/models/plant_models.dart';
import 'genie_service.dart';

class ApiService {
  final GenieService _genieService;

  ApiService({required String apiKey})
      : _genieService = GenieService(apiKey: apiKey);

  Future<AnalysisResultData> analyzePlantDisease(
      String photoDataUri, String description) async {
    final prompt = '''
You are an expert botanist AI specializing in diagnosing plant diseases and recommending treatments, with a focus on solutions readily available to home gardeners.

Analyze the provided plant image and description.

Image: \$photoDataUri
Description: \$description

Your analysis should include:
1. Disease Detection: Determine if a plant disease is present. Set 'diseaseDetected' to true or false.
2. Disease Name: If a disease is detected, identify its common name. If the plant appears healthy, state "Healthy" or a similar positive assessment.
3. Suggested Solutions:
   - If a disease is detected, provide a list of practical, actionable solutions. Prioritize solutions that can be implemented at home.
   - If the plant is healthy, provide 2-3 general care tips relevant to the plant type, or a positive note.
4. Confidence Score (Optional): Provide a confidence score between 0.0 and 1.0 for your diagnosis.
5. Possible Causes (Optional): List a few likely causes (e.g., overwatering, pests).

Respond in JSON format with keys: diseaseDetected (bool), diseaseName (string), suggestedSolutions (list of strings), confidenceScore (optional number), possibleCauses (optional list of strings).
''';

    final response = await _genieService.callGeminiModel(prompt);

    if (response.containsKey('candidates') && response['candidates'].isNotEmpty) {
      final text = response['candidates'][0]['output'] as String;
      final Map<String, dynamic> jsonResponse = jsonDecode(text);
      return AnalysisResultData.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to analyze plant disease: No valid response');
    }
  }

  Future<PlantInformation> getPlantInfo(
      String photoDataUri, String description) async {
    final prompt = '''
You are a knowledgeable botanist and plant care expert.
Based on the provided image and optional description, identify the plant and provide comprehensive information about it.

Image: \$photoDataUri
Description: \$description

Your tasks:
1. Determine if the image contains a plant. Set 'isPlant' accordingly.
2. If it is a plant, identify its common and Latin names.
3. Provide a general description of the plant.
4. Offer detailed care tips covering sunlight, watering, soil, fertilizing, humidity, and pruning.
5. Share 2-3 interesting or fun facts about the plant.
6. If the image is not a plant or cannot be identified, set 'isPlant' to false and provide an error message.

Respond in JSON format with keys: isPlant (bool), commonName (string), latinName (string), plantDescription (string), careTips (object), funFacts (list of strings), error (string).
''';

    final response = await _genieService.callGeminiModel(prompt);

    if (response.containsKey('candidates') && response['candidates'].isNotEmpty) {
      final text = response['candidates'][0]['output'] as String;
      final Map<String, dynamic> jsonResponse = jsonDecode(text);
      return PlantInformation.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get plant info: No valid response');
    }
  }

  Future<List<String>> reasonAboutPlantSuggestions(
      String plantCondition, List<String> allSuggestions) async {
    final prompt = '''
Given the following plant condition: \$plantCondition, and a list of suggestions: \$allSuggestions, filter the suggestions to only include those that are relevant to the plant's condition. Return the filtered list of suggestions.

Instructions: Do not return any suggestions that are not relevant to the plant's condition. Only respond with the suggestions, each on their own line. If no suggestions are relevant, return an empty array.
''';

    final response = await _genieService.callGeminiModel(prompt);

    if (response.containsKey('candidates') && response['candidates'].isNotEmpty) {
      final text = response['candidates'][0]['output'] as String;
      final List<dynamic> jsonResponse = jsonDecode(text);
      return jsonResponse.cast<String>();
    } else {
      throw Exception('Failed to get suggestions: No valid response');
    }
  }
}
