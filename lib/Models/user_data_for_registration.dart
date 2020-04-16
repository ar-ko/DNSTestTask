import '../network/network_helper.dart';
import '../models/server_response.dart';
import '../models/user.dart';

class UserDataForRegistration extends User {
  UserDataForRegistration({
    String firstName,
    String lastName,
    String phone,
    String email,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          phone: phone.replaceAll(RegExp(r"[^0-9]"), ''),
          email: email,
        );

  Map<String, String> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
      };

  Future getToken() async {
    final NetworkHelper networkHelper = NetworkHelper(
      url: 'https://vacancy.dns-shop.ru/api/candidate/token',
      token: null,
      user: this,
    );
    final Map<String, dynamic> json = await networkHelper.getData();
    if (json != null) {
      final ServerResponse response = ServerResponse.fromJson(json);
      return response;
    }
    return null;
  }
}
