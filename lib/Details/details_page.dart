import 'package:flutter/material.dart';
import 'package:travel_suggestion/NetworkLayer/api_service.dart';
import '../CustomComponents/custom_appbar.dart';
import '../CustomComponents/elevated_text_button.dart';

class DetailsPage extends StatefulWidget {
  final String destination;
  final int days;

  const DetailsPage({
    super.key,
    required this.destination,
    required this.days,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String _response = '';

  // Function to fetch OpenAI response
  void _fetchOpenAIResponse() async {

    final openAIService = OpenAIService();

    try {
      final data = await openAIService.getOpenAIResponse(
        'Dammi un itinerario dettagliato per questo luogo -> ${widget.destination} suddiviso in ${widget.days} giorni/giorno',
      );
      setState(() {
        _response = data['choices'][0]['text'].trim(); // Update the response
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e'; // Update with error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Itinerary plan',
        icon: Icons.calendar_view_week_outlined,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.transparent, // Make Scaffold background transparent
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey], // Starting and ending colors
            begin: Alignment.topLeft, // Start from the top-left corner
            end: Alignment.bottomRight, // End at the bottom-right corner
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Luogo: ${widget.destination}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Giorni: ${widget.days}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedTextButton(
              onPressed: _fetchOpenAIResponse,
              buttonText: 'Cerca Itinerario'),
            const SizedBox(height: 24),
            Text(
              'Response from OpenAI: $_response', // Display the API response
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}