
import 'package:flutter/foundation.dart';
import 'package:plant_vaidya/models/plant_models.dart';
import 'package:plant_vaidya/services/history_service.dart';
import 'package:plant_vaidya/services/api_service.dart';
import 'package:plant_vaidya/utils/constants.dart';

class AppStateProvider with ChangeNotifier {
  final ApiService _apiService;

  AppStateProvider({required String apiKey}) : _apiService = ApiService(apiKey: apiKey) {
    loadHistory();
  }
  final HistoryService _historyService = HistoryService();

  List<HistoryEntry> _history = [];
  bool _isLoadingHistory = true;
  bool _isProcessing = false;
  AnalysisResultData? _analysisResult;
  PlantInformation? _plantInfoResult;
  String? _error;

  List<HistoryEntry> get history => _history;
  bool get isLoadingHistory => _isLoadingHistory;
  bool get isProcessing => _isProcessing;
  AnalysisResultData? get analysisResult => _analysisResult;
  PlantInformation? get plantInfoResult => _plantInfoResult;
  String? get error => _error;


  Future<void> loadHistory() async {
    _isLoadingHistory = true;
    notifyListeners();
    _history = await _historyService.getHistory();
    _isLoadingHistory = false;
    notifyListeners();
  }

  Future<void> addHistoryEntry(OmitIdAndDateHistoryEntry entryData, String imageDataUri, String? originalImageName) async {
    final newEntry = HistoryEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      imageDataUri: imageDataUri,
      originalImageName: originalImageName,
      description: entryData.description,
      diseaseDetected: entryData.diseaseDetected,
      diseaseName: entryData.diseaseName,
      suggestedSolutions: entryData.suggestedSolutions,
    );
    await _historyService.addHistoryEntry(newEntry);
    _history.insert(0, newEntry);
    if (_history.length > 50) _history.removeLast();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    await _historyService.clearHistory();
    _history = [];
    notifyListeners();
  }

  Future<void> handleSubmit(String photoDataUri, String description, String? originalImageName, AnalysisAction action) async {
    _isProcessing = true;
    _error = null;
    _analysisResult = null;
    _plantInfoResult = null;
    notifyListeners();

    try {
      if (action == AnalysisAction.disease) {
        AnalysisResultData diseaseAnalysis = await _apiService.analyzePlantDisease(photoDataUri, description);
        
        List<String> finalSuggestions = diseaseAnalysis.suggestedSolutions;
        if (diseaseAnalysis.diseaseDetected && diseaseAnalysis.diseaseName.isNotEmpty) {
          final suggestionsToFilter = (diseaseAnalysis.suggestedSolutions.isNotEmpty)
                                      ? diseaseAnalysis.suggestedSolutions
                                      : ALL_PLANT_SUGGESTIONS;
          
          final filteredSuggestions = await _apiService.reasonAboutPlantSuggestions(
            diseaseAnalysis.diseaseName,
            suggestionsToFilter,
          );
          finalSuggestions = filteredSuggestions.isNotEmpty ? filteredSuggestions : diseaseAnalysis.suggestedSolutions;
        }
        
        _analysisResult = AnalysisResultData(
          diseaseDetected: diseaseAnalysis.diseaseDetected,
          diseaseName: diseaseAnalysis.diseaseName,
          suggestedSolutions: finalSuggestions,
        );

        addHistoryEntry(
          OmitIdAndDateHistoryEntry(
            description: description,
            diseaseDetected: _analysisResult!.diseaseDetected,
            diseaseName: _analysisResult!.diseaseName,
            suggestedSolutions: _analysisResult!.suggestedSolutions,
          ),
          photoDataUri,
          originalImageName
        );

      } else if (action == AnalysisAction.info) {
        _plantInfoResult = await _apiService.getPlantInfo(photoDataUri, description);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }
}

// Helper class for addHistoryEntry to match types
class OmitIdAndDateHistoryEntry {
  final String? description;
  final bool diseaseDetected;
  final String diseaseName;
  final List<String> suggestedSolutions;

  OmitIdAndDateHistoryEntry({
    this.description,
    required this.diseaseDetected,
    required this.diseaseName,
    required this.suggestedSolutions,
  });
}

