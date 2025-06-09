import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plant_vaidya/models/plant_models.dart';

class HistoryService {
  static const String _historyKey = 'vaidyaHistory';
  static const int _maxHistoryItems = 50;

  Future<List<HistoryEntry>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey);
    if (historyJson == null) {
      return [];
    }
    return historyJson.map((item) => HistoryEntry.fromJson(jsonDecode(item))).toList();
  }

  Future<void> addHistoryEntry(HistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    List<HistoryEntry> currentHistory = await getHistory();
    currentHistory.insert(0, entry); // Add to the beginning
    if (currentHistory.length > _maxHistoryItems) {
      currentHistory = currentHistory.sublist(0, _maxHistoryItems);
    }
    final historyJson = currentHistory.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_historyKey, historyJson);
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  Future<HistoryEntry?> getHistoryEntryById(String id) async {
    final history = await getHistory();
    try {
      return history.firstWhere((entry) => entry.id == id);
    } catch (e) {
      return null;
    }
  }
}
