import 'package:flutter/material.dart';
import 'package:korean_spanish_app/features/words/services/words_services.dart';
import 'package:korean_spanish_app/models/word/word.dart';

class WordProvider with ChangeNotifier {
  List<Word> _words = [];
  List<Word> get words => _words;

  WordsServices apiService = WordsServices();

  Future<void> loadWords() async {
    // _words = await ApiService.fetchWords();
    _words = await apiService.fetchWords();
    notifyListeners(); // Notifica a la app que los datos cambiaron
  }
}
