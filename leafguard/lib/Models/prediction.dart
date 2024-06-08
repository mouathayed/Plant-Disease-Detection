class Prediction {
  final String className;
  final String confidence;
  final String description;
  final String examplePicture;
  final String prevention;
  final String treatment;

  Prediction({
    required this.className,
    required this.confidence,
    required this.description,
    required this.examplePicture,
    required this.prevention,
    required this.treatment,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      className: json['class_name'] as String,
      confidence: json['confidence'] as String,
      description: json['description'] as String,
      examplePicture: json['example_picture'] as String? ?? 'N/A',
      prevention: json['prevention'] as String? ?? 'N/A',
      treatment: json['treatment'] == "NaN" ? "No treatment needed" : json['treatment'] as String? ?? 'N/A',
    );
  }

}

class Predictions {
  final Prediction prediction1;
  final Prediction prediction2;
  final Prediction prediction3;

  Predictions({
    required this.prediction1,
    required this.prediction2,
    required this.prediction3,
  });

  factory Predictions.fromJson(Map<String, dynamic> json) {
    return Predictions(
      prediction1: Prediction.fromJson(json['prediction_1']),
      prediction2: Prediction.fromJson(json['prediction_2']),
      prediction3: Prediction.fromJson(json['prediction_3']),
    );
  }
}
