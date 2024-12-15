import 'dart:convert';
import 'package:http/http.dart' as http;

class GraphQLService {
  final String endpoint = 'http://localhost:4000/graphql';

  Future<dynamic> postQuery(String query) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
