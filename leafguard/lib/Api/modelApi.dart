import 'dart:convert';
import 'package:http/http.dart' as http;

class modelApi {
  final String baseUrl;
  modelApi({required this.baseUrl});

  Future<Map<String, dynamic>> predict(String imagePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/predict'));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('statusCode == 200');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load predictions');
    }
  }
}
