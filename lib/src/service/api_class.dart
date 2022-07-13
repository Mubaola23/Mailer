import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:maillerapp/src/model/email_history_response.dart';

import '../core/constants.dart';

class ApiClass {
  Future sendEmail(String name, String email, String message) async {
    final url = Uri.parse("$baseUrl/email/send");
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'accessToken': accessToken,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message
          }
        }));
    return response.statusCode;
  }

  Future<EmailHistoryResponse> history() async {
    try {
      final url = Uri.parse(
          "https://api.emailjs.com/api/v1.1/history?user_id=$userId&accessToken=$accessToken&page=1&count=50");
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      // if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return EmailHistoryResponse.fromJson(res);
      // }
    } on SocketException {
      throw "No internet connection";
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
