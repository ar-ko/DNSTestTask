import 'package:dns_test_task/RegisterData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 11 && value.isNotEmpty)
      return 'Номер должен состоять из 11 цифр';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value.isNotEmpty)
      return 'Введите корректный email';
    else
      return null;
  }

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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
                margin: const EdgeInsets.fromLTRB(15, 23, 16, 0),
                child: _textFields()),
          ),
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
          validator: (value) {
            if (value.length < 2 && value.isNotEmpty) {
              return 'Введите свое имя';
            }
            return null;
          },
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
          autovalidate: true,
          controller: _lastNameController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: 'Фамилия',
            hintStyle: TextStyle(fontSize: 16),
          ),
          validator: (value) {
            if (value.length < 2 && value.isNotEmpty) {
              return 'Введите свою фамилию';
            }
            return null;
          },
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
          autovalidate: true,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'E-mail',
            hintStyle: TextStyle(fontSize: 16),
          ),
          validator: validateEmail,
        ),
        SizedBox(
          height: 28,
        ),
        TextFormField(
          autovalidate: true,
          controller: _phoneController,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: 'Телефон',
            hintStyle: TextStyle(fontSize: 16),
          ),
          validator: validateMobile,
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
      RegisterData user = new RegisterData(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text);

      httpPost(RegisterData user) async {
        var response = await http.post(
          'https://vacancy.dns-shop.ru/api/candidate/token',
          body: jsonEncode({
            "firstName": user.firstName,
            "lastName": user.lastName,
            "phone": user.phone,
            "email": user.email
          }),
          headers: {
            'Content-Type': 'application/json; charset=utf-8 ',
          },
        );

        var kek = json.decode(utf8.decode(response.bodyBytes));
        print(kek);
        print('StatusCode: ${response.statusCode}');
      }

      httpPost(user);
    }
  }
}
