import '../models/user_data_for_registration.dart';

class ScreenArguments {
  final UserDataForRegistration user;
  final String token;

  ScreenArguments(this.user, this.token);
}
