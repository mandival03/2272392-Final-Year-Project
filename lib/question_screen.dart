import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'question_provider.dart';
import 'question_service.dart';
import 'summary_screen.dart';
import 'main.dart'; 

class QuestionScreen extends StatefulWidget {
  final String topic;

  QuestionScreen({required this.topic});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  TextEditingController _answerController = TextEditingController();
  int _questionCount = 0;
  int _score = 0;
  final QuestionService _service = QuestionService();

  bool _isSubmitting = false;

  
@override
void initState() {
  super.initState();
  Provider.of<QuestionProvider>(context, listen: false).fetchQuestions(widget.topic);
}

  void _loadNewQuestion() {
    final provider = Provider.of<QuestionProvider>(context, listen: false);
    if (provider.currentIndex >= provider.questions.length - 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SummaryScreen(topic: widget.topic)),);
    } else {
      provider.nextQuestion();
      _answerController.clear;
    }
  }

  void _checkAnswer(String userAnswer, String correctAnswer) async {
  final provider = Provider.of<QuestionProvider>(context, listen: false);

  setState(() {
    _isSubmitting = true;
  });
  bool isCorrect = await _service.validateAnswer(userAnswer, correctAnswer);
  
  provider.markAnswer(isCorrect, widget.topic);

  _answerController.clear();

  if (provider.currentIndex >= provider.questions.length - 1) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => SummaryScreen(topic: widget.topic)),
    );
  } else {
    provider.nextQuestion();
    _answerController.clear();
  }

  setState(() {
    _isSubmitting = false;
  });
}



  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quiz Complete!"),
        content: Text("You scored $_score out of 10."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("${widget.topic} - Question ${questionProvider.currentIndex + 1}/10")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (questionProvider.isLoading)
              Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Generating and Validating questions...", style: TextStyle(fontSize: 18)),]))
            else
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _parseMathAndText(questionProvider.question, fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 20),

                    TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        labelText: "Enter Your Answer",
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String userAnswer = _answerController.text.trim();
                            _checkAnswer(userAnswer, questionProvider.answer); 
                            //_loadNewQuestion(); 
                          },
                          child: Text("Submit", style: TextStyle(fontSize: 18)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _checkAnswer("", questionProvider.answer);
                            //_loadNewQuestion(); 
                          },
                          child: Text("Skip and Show Answer", style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _parseMathAndText(String text, {double fontSize = 18}) {
    List<Widget> widgets = [];
    RegExp mathPattern = RegExp(r"\$(.*?)\$"); 

    Iterable<Match> matches = mathPattern.allMatches(text);
    int lastMatchEnd = 0;

    for (Match match in matches) {
      if (match.start > lastMatchEnd) {
        widgets.add(
          Text(
            text.substring(lastMatchEnd, match.start),
            style: TextStyle(fontSize: fontSize),
            softWrap: true,
          ),
        );
      }

      widgets.add(
        Math.tex(
          match.group(1)!,
          textStyle: TextStyle(fontSize: fontSize + 4, fontWeight: FontWeight.bold),
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      widgets.add(
        Text(
          text.substring(lastMatchEnd),
          style: TextStyle(fontSize: fontSize),
          softWrap: true,
        ),
      );
    }

    return widgets;
  }
}