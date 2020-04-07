import '../Models/UserDataForRegistration.dart';

class FullUserData extends UserDataForRegistration {
  String githubProfileUrl;
  String summaryUrl;

  FullUserData({UserDataForRegistration user, String githubProfileUrl, String summaryUrl}) {
    this.firstName = user.firstName;
    this.lastName = user.lastName;
    this.phone = user.phone;
    this.email = user.email;
    this.githubProfileUrl = githubProfileUrl;
    this.summaryUrl = summaryUrl;
  }

  Map<String, String> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
        'githubProfileUrl' : githubProfileUrl,
        'summary' : summaryUrl,
      };
}