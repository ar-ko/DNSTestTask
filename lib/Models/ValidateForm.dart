class ValidateForm {
  bool _firstNameValided = false;
  bool _lastNameValided = false;
  bool _emailValided = false;
  bool _phoneValided = false;

  bool get buttonEnabled =>
      _firstNameValided && _lastNameValided && _emailValided && _phoneValided;

  String validateFirsttName(String value) {
    if (value.length < 2 && value.isNotEmpty) {
      _firstNameValided = false;
      return 'Введите свое имя';
    }
    _firstNameValided = true;
    return null;
  }

  String validateLastName(String value) {
    if (value.length < 2 && value.isNotEmpty) {
      _lastNameValided = false;
      return 'Введите свою фамилию';
    }
    _lastNameValided = true;
    return null;
  }

  String validateMobile(String value) {
    if (value.length != 17 && value.isNotEmpty) {
      _phoneValided = false;
      return 'Номер должен состоять из 11 цифр';
    } else {
      _phoneValided = true;
      return null;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value.isNotEmpty) {
      _emailValided = false;
      return 'Введите корректный email';
    } else {
      _emailValided = true;
      return null;
    }
  }
}
