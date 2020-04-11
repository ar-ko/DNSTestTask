import '../Models/UserDataForRegistration.dart';
import '../Models/User.dart';
import '../Network/NetworkService.dart';
import '../Models/ServerResponse.dart';

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

  Future register(String token, FullUserData user) async {
    final NetworkHelper networkHelper = NetworkHelper(
      url: 'https://vacancy.dns-shop.ru/api/candidate/test/summary',
      token: token,
      user: user,
    );
    final Map<String, dynamic> json = await networkHelper.getData();
    final ServerResponse response = ServerResponse.fromJson(json);
    return response;
  }
}
