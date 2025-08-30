import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;

  int _currentQuestionCount = 0;
  int _correctAnswered = 0;

  List? questions;

  BuildContext context;
  HomePageProvider({required this.context}) {
    // https://opentdb.com/api.php?amount=10&difficulty=easy&type=boolean
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    _getQuestionData();
  }

  Future<void> _getQuestionData() async {
    Response _res = await _dio.get(
      '',
      queryParameters: {
        "amount": _maxQuestions,
        "difficulty": "easy",
        "type": "boolean",
      },
    );

    var _data = jsonDecode(_res.toString());
    questions = await _data["results"];
    notifyListeners();
  }

  String getCurrentQuestion() {
    return questions![_currentQuestionCount]['question'];
  }

  Future<void> getAnswerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _answer;
    _currentQuestionCount++;
    isCorrect ? _correctAnswered++ : null;
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);

    if (_currentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text("Game Over"),
          content: Text('You Scored: $_correctAnswered/$_maxQuestions'),
        );
      },
    );
    await Future.delayed(Duration(seconds: 4));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
