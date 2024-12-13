import 'package:flutter/material.dart';

class InputDataField extends StatelessWidget {
  final String header; // Titolo sopra il TextField
  final String placeholder; // Placeholder nel TextField
  final TextInputType inputType; // Tipo di input (es. stringa, numeri)
  final Function(String)? onChanged; // Callback per gestire l'input

  // ignore: use_super_parameters
  const InputDataField({
    Key? key, 
    this.header = '', // Valore di default
    this.placeholder = '', // Valore di default
    this.inputType = TextInputType.text, // Default: input di testo
    this.onChanged, // Callback opzionale
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            labelText: placeholder,
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.white24,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

