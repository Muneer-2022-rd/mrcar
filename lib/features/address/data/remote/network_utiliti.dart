import 'package:http/http.dart' as http;

class NetworkUtiliti {
  static Future<String?> fetchURL(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
