

abstract class User {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;

  User({
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
  });

  Map<String, String> toJson();
}
