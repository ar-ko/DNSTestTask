class UserData {
  String firstName;
  String lastName;
  String phone;
  String email;

  UserData({this.firstName, this.lastName, this.phone, this.email});

  Map<String, String> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
      };
}
