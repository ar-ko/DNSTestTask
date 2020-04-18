import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;


import '../models/user.dart';


class NetworkHelper {
  NetworkHelper({
    this.url,
    this.user,
    this.token,
  }) {
    if (token != null) {
      headers = {
        'Content-Type': 'application/json; charset=utf-8 ',
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {
        'Content-Type': 'application/json; charset=utf-8 ',
      };
    }
  }

  final String url;
  final User user;
  final String token;
  Map<String, String> headers;

  Future getData() async {
    try {
      final http.Response response = await http.post(
        url,
        body: jsonEncode(user),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(utf8.decode(response.bodyBytes));
      } else {
        developer.log('${response.statusCode}');
      }
    } catch(err) {
      developer.log('$err');
      return null;
    }
  }
}
