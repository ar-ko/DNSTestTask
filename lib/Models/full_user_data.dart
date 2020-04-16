import '../models/user_data_for_registration.dart';
import '../models/user.dart';
import '../network/network_helper.dart';
import '../models/server_response.dart';

class FullUserData extends User {
  final String githubProfileUrl;
  final String summaryUrl;

  FullUserData({
    UserDataForRegistration user,
    this.githubProfileUrl,
    this.summaryUrl,
  }) : super(
          firstName: user.firstName,
          lastName: user.lastName,
          phone: user.phone,
          email: user.email,
        );

  Map<String, String> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
        'githubProfileUrl': githubProfileUrl,
        'summary': summaryUrl,
      };

  Future register(String token) async {
    final NetworkHelper networkHelper = NetworkHelper(
      url: 'https://vacancy.dns-shop.ru/api/candidate/summary',
      token: token,
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
