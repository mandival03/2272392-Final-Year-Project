import 'package:flutter/material.dart';
import 'question_service.dart';

class QuestionProvider extends ChangeNotifier {
  final Map<String, double> _topicProgress = {};
  List<Map<String, String>> _qaList = [];
  List<bool> _results = [];
  int _currentIndex = 0;
  bool _loading = false;

  bool get isLoading => _loading;
  int get currentIndex => _currentIndex;
  List<Map<String, String>> get questions => _qaList;
  List<bool> get results => _results;

  final QuestionService _service = QuestionService();

  String get question => _qaList.isNotEmpty ? _qaList[_currentIndex]["question"]! : "";
  String get answer => _qaList.isNotEmpty ? _qaList[_currentIndex]["answer"]! : "";
  Map<String, double> get topicProgress => _topicProgress;

  Future<void> fetchQuestions(String topic) async {
    _loading = true;
    notifyListeners();

    _qaList = await _service.generateValidatedQuestionsList(topic);
    _results = List.filled(_qaList.length, false);
    _currentIndex = 0;

    _loading = false;
    notifyListeners();
  }

  void markAnswer(bool isCorrect, [String? topic]) {
    if (_currentIndex < _results.length) {
      _results[_currentIndex] = isCorrect;

      if (isCorrect && topic != null){
        double currentProgress = _topicProgress[topic] ?? 0.0;
        _topicProgress[topic] = (currentProgress + 0.01).clamp(0.0, 1.0);
      }

      notifyListeners();
    }
  }

  void nextQuestion() {
    if (_currentIndex < _qaList.length - 1) {
      _currentIndex++;
      print("Moved to index $_currentIndex");
      notifyListeners();
    }
  }
}