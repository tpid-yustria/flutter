import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/article.dart';

class ApiService {
  static const String _baseUrl = "https://newsapi.org/v2/";
  static const String _apiKey = "ed2659dc60d648359072291975cc7485";
  static const String _country = 'id';

  Future<Articles> topHeadline() async {
    final response = await http.get(Uri.parse(
        _baseUrl + "top-headlines?country=$_country&apiKey=$_apiKey"));

    if (response.statusCode == 200) {
      return Articles.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headline');
    }
  }
}