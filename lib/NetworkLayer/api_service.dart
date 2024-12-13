import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? 'Api key not found';

  // Endpoint URL for OpenAI API
  static const String _baseUrl = 'https://api.openai.com/v1/completions';

  // Function to request data from OpenAI API
  Future<Map<String, dynamic>> getOpenAIResponse(String prompt) async {
    // Ensure the API key is not empty
    if (apiKey.isEmpty) {
      throw Exception('API Key is missing. Please add your API key.');
    }

    try {
      // Make a POST request to OpenAI API
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo', //  Choose the model you want to use ['gpt-4o-mini','gpt-3.5-turbo','text-embedding-3-small']
          'messages': [ {'role': 'user', 'content': prompt} ],
          'max_tokens': 750, // Adjust according to your needs
        }),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> data = jsonDecode(response.body);
        return data; // You can return the entire response or process it further
      } else {
        throw Exception('Failed to load response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}