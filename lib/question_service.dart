
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secrets.dart';

class QuestionService {
  final String apiKey = OPENAI_API_KEY;
  final String gptModel = "gpt-3.5-turbo";
  final String fineTunedModel = "ft:gpt-3.5-turbo-0125:ramei::BAisiETm"; 

  Future<List<Map<String, String>>> generateQuestionsList(String topic) async {
  final String apiKey = OPENAI_API_KEY;
  final String gptModel = "gpt-3.5-turbo";

  if (apiKey.isEmpty) {
    return [{"question": "Error", "answer": "API Key missing."}];
  }

  try {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": gptModel,
        "messages": [
          {
            "role": "system",
            "content": r"You are a GCSE maths tutor generating quiz questions. All math expressions should be formatted in LaTeX using dollar signs ($...$). Provide only a numbered list of 10 questions and answers, each question followed by 'Answer:' and the solution in LaTeX."
          },
          {
            "role": "user",
            "content": "Create 10 different GCSE maths questions on the topic: $topic.\n\nUse this format:\n\nQuestion 1:\n[SOME QUESTION TEXT HERE]\n\nAnswer:\n[SOLUTION IN LATEX]"
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      String content = jsonDecode(response.body)['choices'][0]['message']['content'];
      RegExp pattern = RegExp(r"Question\s*\d+:(.*?)Answer\s*:(.*?)(?=Question\s*\d+:|$)", dotAll: true);
      List<Map<String, String>> results = [];

      for (final match in pattern.allMatches(content)) {
        String question = match.group(1)!.trim();
        String answer = match.group(2)!.trim();
        results.add({'question': question, 'answer': answer});
      }

      return results;
    } else {
      return [{"question": "Error", "answer": "API request failed."}];
    }
  } catch (e) {
    return [{"question": "Error", "answer": "Exception: $e"}];
  }
}


Future<List<Map<String, String>>> generateValidatedQuestionsList(String topic) async {
  final List<Map<String, String>> finalList = [];

  while (finalList.length < 10) {
    final rawList = await generateQuestionsList(topic);

    for (final qa in rawList) {
      final String question = qa['question']!;
      final String answer = qa['answer']!;

      bool isValid = await validateGeneratedQA(question, answer);
      if (isValid) {
        finalList.add({'question': question, 'answer': answer});
        print("Added: ${finalList.length}/10");
      } else {
        print("Invalid Q&A. Skipping...");
        continue;
      }

      if (finalList.length >= 10) break;
    }
  }

  return finalList;
}


Future<List<Map<String, String>>> generateValidatedMockExam() async {
  final List<Map<String, String>> finalList = [];

  while (finalList.length < 15) {
    final rawBatch = await generateMockExam();

    for (final qa in rawBatch) {
      final String question = qa['question']!;
      final String answer = qa['answer']!;

      bool isValid = await validateGeneratedQA(question, answer);
      if (isValid) {
        finalList.add({'question': question, 'answer': answer});
        print("Added");
      } else {
        print("Invalid");
        continue;
      }

      if (finalList.length >= 15) break;
    }
  }

  return finalList;
}

  Future<bool> validateAnswer(String userAnswer, String correctAnswer) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": fineTunedModel,
          "messages": [
            {"role": "system", "content": "You are an AI that verifies GCSE exam answers. Return ONLY 'Correct' or 'Incorrect'."},
            {"role": "user", "content": "Generated Answer: $correctAnswer"},
            {"role": "user", "content": "User Answer: $userAnswer"},
          ]
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['choices'][0]['message']['content'].trim() == "Correct";
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> validateGeneratedQA(String question, String answer) async {
  try {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": fineTunedModel,
        "messages": [
          {
            "role": "system",
            "content": "You are an AI that verifies GCSE maths question-answer pairs. You will be given a question and an answer. Determine whether the answer is correct for the given question. Reply only with 'Correct' or 'Incorrect'."
          },
          {
            "role": "user",
            "content": "Question: $question\nAnswer: $answer"
          },
        ]
      }),
    );

    if (response.statusCode == 200) {
      final String result = jsonDecode(response.body)['choices'][0]['message']['content'].trim();
      return result == "Correct";
    } else {
      print("API Error: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Exception in validateGeneratedQA: $e");
    return false;
  }
}


  Future<List<Map<String, String>>> generateMockExam() async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "model": gptModel,
      "messages": [
        {
          "role": "system",
          "content": r"""
You are a GCSE Maths tutor.

Please generate a set of 15 exam-style maths questions, mixing difficulty (easy, medium, hard), formatted like an AQA GCSE exam paper.

Use the following format exactly:

Question 1:
[Insert question text here with LaTeX where needed using $...$]

Answer:
[Insert answer here using LaTeX where needed using $...$]

Question 2:
...

Only return plain text. Do not include any LaTeX preamble like \documentclass or \begin{document}.
Do not use headings or sections.

Make sure every question is followed by 'Answer:' on the next line.
Do not include explanations or steps. Just questions and answers.
"""
        }
      ]
    }),
  );

  if (response.statusCode == 200) {
    String content = jsonDecode(response.body)['choices'][0]['message']['content'];
    RegExp pattern = RegExp(r"Question\s*\d+:(.*?)Answer\s*:(.*?)(?=Question\s*\d+:|$)", dotAll: true);
    List<Map<String, String>> results = [];

    for (final match in pattern.allMatches(content)) {
      results.add({
        'question': match.group(1)!.trim(),
        'answer': match.group(2)!.trim()
      });
    }

    if (results.isEmpty) {
      print("WARNING: EMPTY");
      print("RAW RESPONSE:\n$content");
    }

    return results;
  } else {
    return [{"question": "Error", "answer": "API failed"}];
  }
}
}