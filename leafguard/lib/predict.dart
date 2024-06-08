import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Api/modelApi.dart';
import 'Models/prediction.dart';
import 'constants.dart';
import 'prediction_details_page.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({Key? key}) : super(key: key);

  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  List<Prediction>? _predictions;

  void getPrediction(File image) async {
  var apiService = modelApi(baseUrl: api);
  try {
    var response = await apiService.predict(image.path);
    print('API Response: $response');
    if (response.isEmpty) {
      throw Exception('Empty response from API');
    }
    var predictions = Predictions.fromJson(response);
    setState(() {
      _predictions = [
        predictions.prediction1,
        predictions.prediction2,
        predictions.prediction3,
      ];
    });
  } catch (e) {
    print('Error fetching prediction: $e');
    setState(() {
      _predictions = [];
    });
  }
}

  pickImageGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _predictions = null;
      });
      getPrediction(_imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Disease Detection"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/upload.jpg'),
                    fit: BoxFit.cover, // Cover ensures the image respects the container's edges
                    colorFilter: _imageFile == null ? ColorFilter.mode(
                        Colors.grey.withOpacity(0.5), BlendMode.dstATop) : null,
                  ),
                ),
                child: _imageFile != null ? ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Matches the Container's border radius
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit.cover, // Ensures the image fills the bounds of the ClipRRect
                  ),
                ) : null,
              ),
              const SizedBox(height: 20),
              if (_predictions != null)
                for (var pred in _predictions!)
                  Card(
                    child: ListTile(
                      title: Text(pred.className),
                      subtitle: Text('${(double.parse(pred.confidence.replaceFirst('%', ''))).toStringAsFixed(2)}% confidence'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PredictionDetailsPage(prediction: pred),
                          ),
                        ),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(foregroundColor: Colors.white,),
                onPressed: pickImageGallery,
                child: const Text("Pick from gallery"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
