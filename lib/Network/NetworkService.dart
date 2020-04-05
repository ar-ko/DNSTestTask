import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/UserData.dart';

class NetworkService {
  getKey(UserData user) async {
    var response = await http.post(
      'https://vacancy.dns-shop.ru/api/candidate/token',
      body: jsonEncode(user),
      headers: {
        'Content-Type': 'application/json; charset=utf-8 ',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      print(response.statusCode);
    }
  }
}
