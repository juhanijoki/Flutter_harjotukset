import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future<dynamic> getData() async {
    http.Response response;

    response = await http.get(Uri.parse(url));

    // Tarkistus onnistuiko pyyntö.
    if (response.statusCode == 200) {
      String data = response.body;

      dynamic jsonObjects = jsonDecode(data);

      return jsonObjects;
    } else {
      print(response.statusCode);
    }
  }
}
