import '../Network/NetworkService.dart';
import '../Models/ServerResponse.dart';
import '../Models/User.dart';

class UserDataForRegistration extends User {
  UserDataForRegistration({
    String firstName,
    String lastName,
    String phone,
    String email,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
        );

  Map<String, String> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
      };

  Future getToken(UserDataForRegistration user) async {
    final NetworkHelper networkHelper = NetworkHelper(
      url: 'https://vacancy.dns-shop.ru/api/candidate/token',
      token: null,
      user: user,
    );
    final Map<String, dynamic> json = await networkHelper.getData();
    final  ServerResponse response = ServerResponse.fromJson(json);
    return response;
  }
}
