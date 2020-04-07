import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/UserDataForRegistration.dart';
import '../Models/FullUserData.dart';

class NetworkService {
  getToken(UserDataForRegistration user) async {
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

    registerCandidate(FullUserData user, String token) async {
    var response = await http.post(
      'https://vacancy.dns-shop.ru/api/candidate/test/summary',
      body: jsonEncode(user),
      headers: {
        'Content-Type': 'application/json; charset=utf-8 ',
        'Authorization': 'Bearer $token',
      },
    );
    
    /*print(json.decode(utf8.decode(response.bodyBytes)));
    if (response.statusCode == 200) { */     
      return json.decode(utf8.decode(response.bodyBytes));
    /*} else {
      print(response.statusCode);
    }*/
  }
}
