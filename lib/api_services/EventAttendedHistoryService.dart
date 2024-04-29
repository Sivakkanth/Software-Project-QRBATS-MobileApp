import 'dart:convert';
import 'package:http/http.dart' as http;


import '../api_config/api_constants.dart';
import '../models/AttendanceHistoryData.dart';

class EventAttendedHistoryService{
  static Future<List<AttendanceData>> fetchAttendanceList(int studentId) async {
    final apiUrl = '${ApiConstants.baseUrl}${ApiConstants.getallattendancebystudentidEndpoint}';
    final requestBody = jsonEncode({'studentId': studentId});

    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'}, body: requestBody);

    print(response.statusCode);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((data) => AttendanceData.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load attendance data');
    }
  }
}