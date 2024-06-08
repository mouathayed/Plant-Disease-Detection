import 'Models/prediction.dart';
import 'package:flutter/material.dart';

class PredictionDetailsPage extends StatelessWidget {
  final Prediction prediction;

  const PredictionDetailsPage({Key? key, required this.prediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prediction.className),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(prediction.examplePicture, errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Image loading failed'));
            }),
            const SizedBox(height: 20),
            Text(prediction.description, style: const TextStyle(fontSize: 16, color: Colors.black)),
            const SizedBox(height: 20),
            const Text('Prevention:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black)),
            Text(prediction.prevention, style: const TextStyle(fontSize: 16, color: Colors.black)),
            const SizedBox(height: 20),
            const Text('Treatment:', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25, color: Colors.black)),
            Text(prediction.treatment, style: const TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}