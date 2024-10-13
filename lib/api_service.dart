import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String apiUrl = 'https://yourapiurl.com/request_blood';

  static Future<void> sendBloodRequest(String date, String time, String location, String patientName, int bloodBags) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'date': date,
        'time': time,
        'location': location,
        'patient_name': patientName,
        'blood_bags': bloodBags,
      }),
    );
    if (response.statusCode == 200) {
      print('Request sent successfully');
    } else {
      print('Failed to send request');
    }
  }
}
