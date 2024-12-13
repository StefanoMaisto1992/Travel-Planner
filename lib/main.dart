import 'package:flutter/material.dart';
import 'CustomComponents/input_data.dart';
import 'CustomComponents/custom_appbar.dart';
import 'Details/details_page.dart';
import 'CustomComponents/elevated_text_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: 'config.env');
  print(dotenv.env['OPENAI_API_KEY']); // Dovrebbe stampare la chiave API
  testNetwork();
  runApp(const MyApp());
}

void testNetwork() async {
  try {
    final response = await http.get(Uri.parse('https://www.google.com'));
    if (response.statusCode == 200) {
      print('Connection Successful!');
    } else {
      print('Failed to connect');
    }
  } catch (e) {
    print('Error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(
      title: 'Travel Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Travel planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String destination = '';
  int days = 1;

  void onConfirmPressed() {
    if (destination.isNotEmpty && days > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(
            destination: destination,
            days: days
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Compila tutti i campi prima di continuare!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(213, 54, 244, 105),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: const CustomAppBar(
        title: 'Travel planner',
        icon: Icons.flight_takeoff,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              InputDataField(
                header: 'Dove vorresti andare?',
                placeholder: 'Inserisci la destinazione',
                onChanged: (p0) {
                  setState(() {
                    destination = p0;
                  });
                },
              ),
              const SizedBox(height: 20),
              InputDataField(
                header: 'Giorni previsti?',
                placeholder: 'Inserisci i giorni',
                inputType: TextInputType.number,
                onChanged: (intValue) {
                  setState(() {
                    final int parsedValue = int.tryParse(intValue) ?? 0;
                    days = parsedValue == 0 ? 1 : parsedValue;
                  });
                },
              ),
               const SizedBox(height: 80),
               ElevatedTextButton
               (buttonText: 'Continua',
                onPressed: () => { onConfirmPressed() })
          ]),
        ),
      ),
    );
  }
}
