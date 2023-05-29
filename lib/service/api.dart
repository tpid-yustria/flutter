import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_finder/models/job.dart';

class ApiService {
  static const String _baseUrl = "https://api-job.test/api/";

  Future<Jobs> allJob() async {
    final response = await http.get(Uri.parse(_baseUrl + "job"));

    if (response.statusCode == 200) {
      return Jobs.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headline');
    }
  }
}