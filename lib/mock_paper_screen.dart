import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'question_service.dart';

class MockPaperScreen extends StatefulWidget {
  @override
  _MockPaperScreenState createState() => _MockPaperScreenState();
}

class _MockPaperScreenState extends State<MockPaperScreen> {
  bool isLoading = true;
  bool showAnswers = false;
  List<Map<String, String>> paper = [];

  @override
  void initState() {
    super.initState();
    _generateMockPaper();
  }

  Future<void> _generateMockPaper() async {
    final service = QuestionService();
    final result = await service.generateValidatedMockExam();

    setState(() {
      paper = result;
      isLoading = false;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Mock Paper")),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Generating and Validating mock paper...", style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => showAnswers = !showAnswers);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      showAnswers ? "Hide Answers" : "Show Answers",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: paper.length,
                    itemBuilder: (context, index) {
                      final q = paper[index]['question']!;
                      final a = paper[index]['answer']!;
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Q${index + 1}:", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    ..._parseMathAndText(q, fontSize: 20),
                                  ],
                                ),
                              ),
                              if (showAnswers) ...[
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Answer:", style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(height: 4),
                                      ..._parseMathAndText(a, fontSize: 20),
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    ),
  );
}

  List<Widget> _parseMathAndText(String text, {double fontSize = 16}) {
    List<Widget> widgets = [];
    RegExp mathPattern = RegExp(r"\$(.*?)\$");

    Iterable<Match> matches = mathPattern.allMatches(text);
    int lastMatchEnd = 0;

    for (Match match in matches) {
      if (match.start > lastMatchEnd) {
        widgets.add(Text(text.substring(lastMatchEnd, match.start), style: TextStyle(fontSize: fontSize)));
      }
      widgets.add(Math.tex(match.group(1)!, textStyle: TextStyle(fontSize: fontSize + 4)));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      widgets.add(Text(text.substring(lastMatchEnd), style: TextStyle(fontSize: fontSize)));
    }

    return widgets;
  }
}