import 'package:dns_test_task/Network/NetworkService.dart';
import 'package:dns_test_task/Screens/SendingDataScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Models/UserData.dart';
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

  final focusLastName = FocusNode();
  final focusEmail = FocusNode();
  final focusPhone = FocusNode();

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 23, 16, 0),
                  child: _textFields()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomWigets(context),
    );
  }

  // MARK: text fields

  Widget _textFields() {
    return Column(
      children: [
        TextFormField(
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
            FocusScope.of(context).requestFocus(focusLastName);
          },
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
          focusNode: focusLastName,
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
            FocusScope.of(context).requestFocus(focusEmail);
          },
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
          focusNode: focusEmail,
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
            FocusScope.of(context).requestFocus(focusPhone);
          },
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
          focusNode: focusPhone,
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

  Widget _bottomWigets(BuildContext context) {
    return Container(
        height: 36,
        width: 160,
        margin: const EdgeInsets.only(bottom: 45),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: () {
              _buttonPressed(_formKey);
            },
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
      UserData user = new UserData(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text);

      void _getApiKey() async {
        var json = await NetworkService().getKey(user);
        var response = ServerResponse.fromJson(json);

        if (response.code == 0) {
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SendingDataScreen()),
          );*/
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

      _getApiKey();
    }
  }
}
