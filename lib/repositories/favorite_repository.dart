import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:v2/repositories/token_repository.dart';
import '../models/food_model.dart';

class FavoriteRepository {
  Future<String> TOKEN = TokenRepository().getDeviceId();
  Future<List<Food>> fetchFavorite() async {
    final url = 'http://223.130.139.200/api/like/list/';
    final headers = {
      'Authorization': TOKEN.toString(),
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print('fetch favorite success');
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

  Future<void> addFavorite(Food food) async {
    final url = 'http://223.130.139.200/api/like/';
    final headers = {
      'Authorization': TOKEN.toString(),
      'Content-Type': 'application/json'
    };

    final body = jsonEncode({
      'cook_id': food.id,
    });

    try {
      final response = await http.post(
          Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('add favorite success');
      } else {
        print('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetching Error: $e');
    }
  }

  Future<void> delFavorite(Food food) async {
    final url = 'http://223.130.139.200/api/like/';
    final headers = {
      'Authorization': TOKEN.toString(),
      'Content-Type': 'application/json'
    };

    final body = jsonEncode({
      'cook_id': food.id,
    });

    try {
      final response = await http.delete(
          Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('add favorite success');
      } else {
        print('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Fetching Error: $e');
    }
  }
}