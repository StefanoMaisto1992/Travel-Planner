import 'package:flutter/material.dart';

// Custom ElevatedButton Widget
class ElevatedTextButton extends StatelessWidget {
  final String buttonText; // Text displayed on the button
  final VoidCallback onPressed; // Callback when the button is pressed

  // Constructor
  // ignore: use_super_parameters
  const ElevatedTextButton({
    Key? key,
    required this.buttonText, // The button text
    required this.onPressed, // The onPressed callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Button background color
        padding: const EdgeInsets.all(16), // Button padding
        textStyle: const TextStyle(
          fontSize: 18, // Font size of the text
          color: Color.fromARGB(88, 0, 0, 0), // Text color
          fontWeight: FontWeight.bold, // Font weight
        ),
      ),
      onPressed: onPressed, // Action to take when button is pressed
      child: Text(
        buttonText, // Text for the button
        style: const TextStyle(color: Colors.black), // Text color on the button
      ),
    );
  }
}