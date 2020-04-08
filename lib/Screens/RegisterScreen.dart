import 'package:dns_test_task/Network/NetworkService.dart';
import 'package:dns_test_task/Screens/SendingDataScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Models/UserDataForRegistration.dart';
import '../Models/PhoneTextInputFormatter.dart';
import '../Models/ValidateForm.dart';
import '../Models/ServerResponse.dart';
import '../Network/NetworkService.dart';
import '../Models/ScreenArguments.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ввод данных',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 23, 16, 23),
                  child: _textFields()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomWigets(context, _showButton),
    );
  }

  void _updateButton() {
    setState(() {
      _showButton = _emailController.text.isNotEmpty &&
          _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _formKey.currentState.validate();
    });
  }

  Widget _textFields() {
    return Column(
      children: [
        TextFormField(
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
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
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
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
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
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
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
          //maxLength: 15,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly,
            _mobileFormatter,
          ],
          onFieldSubmitted: (v) {
            _buttonPressed(_formKey);
          },
        ),
      ],
    );
  }

  Widget _bottomWigets(BuildContext context, bool _showButton) {
    return Container(
        height: 36,
        width: 160,
        margin: const EdgeInsets.only(bottom: 45),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: _showButton
                ? () {
                    _buttonPressed(_formKey);
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

  void _buttonPressed(GlobalKey<FormState> _formKey) {
    if (_formKey.currentState.validate()) {
      UserDataForRegistration user = new UserDataForRegistration(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text);

      void _getToken() async {
        var json = await NetworkService().getToken(user);
        var response = ServerResponse.fromJson(json);

        if (response.code == 0) {
          Navigator.pushNamed(
            context,
            SendingDataScreen.routeName,
            arguments: ScreenArguments(
              user,
              response.data,
            ),
          );
        }
      }

      _getToken();
    }
  }
}
