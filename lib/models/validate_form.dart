

class ValidateForm {
  String validateFirstName(String value) {
    if (value.length < 2 && value.isNotEmpty) {
      return 'Введите свое имя';
    }
    return null;
  }

  String validateLastName(String value) {
    if (value.length < 2 && value.isNotEmpty) {
      return 'Введите свою фамилию';
    }
    return null;
  }

  String validateMobile(String value) {
    if (value.length != 17 && value.isNotEmpty) {
      return 'Номер должен состоять из 11 цифр';
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) && value.isNotEmpty) {
      return 'Введите корректный email';
    } else {
      return null;
    }
  }

  String validateGithub(String value) {
    String pattern = r'(http(s)?)(:(\/\/)?)(github\.com\/.+)';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) && value.isNotEmpty) {
      return 'Введите корректную ссылку на github';
    } else {
      return null;
    }
  }

  String validateURL(String value) {
    String pattern = r'(http(s)?)(:(\/\/)).+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value) && value.isNotEmpty) {
      return 'Введите корректную ссылку на резюме';
    } else {
      return null;
    }
  }
}
