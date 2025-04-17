import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:provider/provider.dart';
import 'question_provider.dart';



class SummaryScreen extends StatelessWidget {
  final String topic;
  SummaryScreen({required this.topic});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Results for $topic")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: provider.questions.length,
          itemBuilder: (context, index) {
            bool correct = provider.results[index];
            String q = provider.questions[index]["question"]!;
            String a = provider.questions[index]["answer"]!;

            return Card(
              color: correct ? Colors.green[100] : Colors.red[100],
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Q${index + 1}:"),
                    ..._parseMathAndText(q),
                    SizedBox(height: 5),
                    Text("Correct Answer:"),
                    ..._parseMathAndText(a),
                  ],
                ),
                trailing: Icon(correct ? Icons.check : Icons.close, color: correct ? Colors.green : Colors.red),
              ),
            );
          },
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
      widgets.add(Math.tex(match.group(1)!, textStyle: TextStyle(fontSize: fontSize + 2)));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      widgets.add(Text(text.substring(lastMatchEnd), style: TextStyle(fontSize: fontSize)));
    }

    return widgets;
  }
}