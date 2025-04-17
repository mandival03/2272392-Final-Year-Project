import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart'; 

class OpenAIFileUploader {
  final String apiKey = CHECKING_KEY;  

  Future<String> uploadTrainingData(String filePath) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.openai.com/v1/files"),
    );

    request.headers['Authorization'] = "Bearer $apiKey";
    request.fields['purpose'] = "fine-tune";
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseData);

    if (response.statusCode == 200) {
      print("File uploaded successfully!");
      print("File ID: ${jsonResponse['id']}");
      return jsonResponse['id'];
    } else {
      print("Error uploading file: ${jsonResponse}");
      return "";
    }
  }
}