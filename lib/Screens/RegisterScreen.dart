import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Screens/SendingDataScreen.dart';
import '../Models/UserDataForRegistration.dart';
import '../Models/PhoneTextInputFormatter.dart';
import '../Models/ValidateForm.dart';
import '../Models/ScreenArguments.dart';
import '../Models/ServerResponse.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _mobileFormatter = PhoneTextInputFormatter();
  final _validateForm = ValidateForm();

  final _focusLastName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPhone = FocusNode();

  bool _showButton = false;
  bool _isLoading = false;

  void _updateButton() {
    setState(() {
      _showButton = _emailController.text.isNotEmpty &&
          _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _formKey.currentState.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ввод данных',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 23, 16, 23),
                    child: Column(
                      children: [
                        _firstNameForm(),
                        _indent(),
                        _lastNameForm(),
                        _indent(),
                        _emailForm(),
                        _indent(),
                        _phoneForm(),
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: _bottomButton(context),
      ),
    );
  }

  Widget _firstNameForm() {
    return TextFormField(
      onChanged: (_) {
        _updateButton();
      },
      autovalidate: true,
      controller: _firstNameController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        hintText: 'Имя',
        hintStyle: TextStyle(fontSize: 16),
      ),
      validator: _validateForm.validateFirsttName,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(_focusLastName);
      },
    );
  }

  Widget _lastNameForm() {
    return TextFormField(
      onChanged: (_) {
        _updateButton();
      },
      focusNode: _focusLastName,
      autovalidate: true,
      controller: _lastNameController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        hintText: 'Фамилия',
        hintStyle: TextStyle(fontSize: 16),
      ),
      validator: _validateForm.validateLastName,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(_focusEmail);
      },
    );
  }

  Widget _emailForm() {
    return TextFormField(
      onChanged: (_) {
        _updateButton();
      },
      focusNode: _focusEmail,
      autovalidate: true,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'E-mail',
        hintStyle: TextStyle(fontSize: 16),
      ),
      validator: _validateForm.validateEmail,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(_focusPhone);
      },
    );
  }

  Widget _phoneForm() {
    return TextFormField(
      onChanged: (_) {
        _updateButton();
      },
      focusNode: _focusPhone,
      autovalidate: true,
      controller: _phoneController,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        hintText: 'Телефон',
        hintStyle: TextStyle(fontSize: 16),
      ),
      validator: _validateForm.validateMobile,
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(17),
        WhitelistingTextInputFormatter.digitsOnly,
        _mobileFormatter,
      ],
      onFieldSubmitted: (v) {
        if (_showButton) _buttonPressed();
      },
    );
  }

  Widget _indent() {
    return SizedBox(
      height: 28,
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Container(
        height: 36,
        width: 160,
        margin: const EdgeInsets.only(bottom: 45),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: _showButton
                ? () {
                    _buttonPressed();
                  }
                : null,
            child: Text(
              'ПОЛУЧИТЬ КЛЮЧ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ));
  }

  void _buttonPressed() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      final RegExp exp = RegExp(r"[^0-9]");
      final UserDataForRegistration user = new UserDataForRegistration(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text.replaceAll(exp, ''));

      _getToken(user);
    }
  }

  void _getToken(UserDataForRegistration user) async {
    final ServerResponse response = await user.getToken(user);

    setState(() {
      _isLoading = false;
    });
    if (response != null) {
      if (response.code == 0) {
        Navigator.pushNamed(
          context,
          SendingDataScreenState.routeName,
          arguments: ScreenArguments(
            user,
            response.data,
          ),
        );
      }
    } else {
      _showDialog(response);
    }
  }

  void _showDialog(ServerResponse response) {
    String message;
    if (response == null)
      message = 'Отсутствует соединение с Интеренетом';
    else
      message = response.message;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Icon(
                Icons.warning,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                'Что-то пошло не так',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text(
                'ОК',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
