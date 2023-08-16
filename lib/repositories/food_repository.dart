import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:v2/repositories/token_repository.dart';
import '../models/food_model.dart';

class FoodRepository {
  Future<String> TOKEN = TokenRepository().getDeviceId();
  Future<List<Food>> fetchFoods() async {
    final url = 'http://223.130.139.200/api/cook/list/30/';
    final headers = {
      'Authorization': TOKEN.toString(),
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final List<dynamic> foodJson = json.decode(body);
        return foodJson.map((json) => Food.fromJson(json)).toList();
      } else {
        print('Server Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Fetching Error: $e');
      return [];
    }
  }

}
