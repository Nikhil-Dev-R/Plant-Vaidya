import 'dart:convert';
import 'package:http/http.dart' as http;

class GenieService {
  final String apiKey;
  final String baseUrl;

  GenieService({required this.apiKey, this.baseUrl = 'https://api.gemini.com/v1'});

  Future<Map<String, dynamic>> callGeminiModel(String prompt, {String model = 'gemini-2.0-flash'}) async {
    final url = Uri.parse('\$baseUrl/models/\$model:generateText');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer \$apiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        'maxOutputTokens': 512,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to call Gemini API: \${response.statusCode} \${response.body}');
    }
  }
}
