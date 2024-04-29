import 'dart:convert';
import '../api_config/api_constants.dart';
import 'package:http/http.dart' as http;

class LocationService{
  static Future<double> findLocationDistance(String locationName, double latitude,double longitude) async {
    final apiUrl = '${ApiConstants.baseUrl}${ApiConstants.getAttendanceDistance}';
    final requestBody = jsonEncode({'locationName': locationName,'latitude':latitude,'longitude':longitude});

    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'}, body: requestBody);

    if (response.statusCode == 200) {
      return double.parse(response.body);
    } else {
      throw Exception('Failed to load attendance data');
    }
  }
}