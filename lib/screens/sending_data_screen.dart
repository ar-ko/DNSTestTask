import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/full_user_data.dart';
import '../models/screen_arguments.dart';
import '../models/server_response.dart';
import '../models/validate_form.dart';

class SendingDataScreen extends StatefulWidget {
  @override
  SendingDataScreenState createState() {
    return SendingDataScreenState();
  }
}

class SendingDataScreenState extends State<SendingDataScreen> {
  static const routeName = 'SendingDataScreen';
  final _focusSummaryUrl = FocusNode();

  final _githubProfileUrlController = TextEditingController();
  final _summaryUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ValidateForm _validateForm = ValidateForm();

  bool _showButton = false;
  bool _isLoading = false;

  void _updateButton() {
    setState(() {
      _showButton = _githubProfileUrlController.text.isNotEmpty &&
          _summaryUrlController.text.isNotEmpty &&
          _formKey.currentState.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments arguments =
        ModalRoute.of(context).settings.arguments as ScreenArguments;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              'Отправка данных',
              style: TextStyle(
                color: kAppBarTextColor,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            )),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation(kMainColor),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 23, 16, 23),
                    child: Column(
                      children: [
                        _gihubURLForm(),
                        const SizedBox(height: 29),
                        _summaryURLForm(arguments),
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: _bottomButton(arguments),
      ),
    );
  }

  Widget _gihubURLForm() {
    return TextFormField(
        onChanged: (_) {
          _updateButton();
        },
        autovalidate: true,
        controller: _githubProfileUrlController,
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.text,
        style: kTextFormStyle,
        decoration: const InputDecoration(
          hintText: 'Ссылка на github',
          hintStyle: kHintTextFormStyle,
        ),
        validator: _validateForm.validateGithub,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(_focusSummaryUrl);
        });
  }

  Widget _summaryURLForm(ScreenArguments arguments) {
    return TextFormField(
        onChanged: (_) {
          _updateButton();
        },
        autovalidate: true,
        focusNode: _focusSummaryUrl,
        controller: _summaryUrlController,
        textCapitalization: TextCapitalization.none,
        style: kTextFormStyle,
        decoration: const InputDecoration(
          hintText: 'Ссылка на резюме',
          hintStyle: kHintTextFormStyle,
        ),
        validator: _validateForm.validateURL,
        onFieldSubmitted: (v) {
          if (_showButton) _registerButton(arguments);
        });
  }

  Widget _bottomButton(ScreenArguments arguments) {
    return Container(
        height: 36,
        width: 160,
        margin: const EdgeInsets.only(bottom: 45),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: _showButton
                ? () {
                    _registerButton(arguments);
                  }
                : null,
            child: Text(
              'ЗАРЕГИСТРИРОВАТЬСЯ',
              style: kButtonTextStyle,
            ),
            color: kMainColor,
          ),
        ));
  }

  void _registerButton(ScreenArguments arguments) {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      final FullUserData user = FullUserData(
        user: arguments.user,
        githubProfileUrl: _githubProfileUrlController.text,
        summaryUrl: _summaryUrlController.text,
      );
      _register(user, arguments);
    }
  }

  void _register(FullUserData user, ScreenArguments arguments) async {
    final ServerResponse response =
        await user.register(arguments.token) as ServerResponse;
    setState(() {
      _isLoading = false;
    });
    _showDialog(response);
  }

  void _showDialog(ServerResponse response) {
    String message;
    if (response == null) {
      message = 'Отсутствует соединение с Интеренетом';
    } else {
      message = response.message;
    }

    if (response != null && response.code == 0) {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Заявка успешно отправлена',
              style: kAlertTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            content: Icon(
              Icons.done,
              size: 100,
              color: kMainColor,
            ),
            actions: [
              FlatButton(
                child: const Text(
                  'ОК',
                  style: kAlertButtonTextStyle,
                ),
                color: kMainColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    } else {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Icon(
                  Icons.warning,
                  size: 100,
                  color: kMainColor,
                ),
                const Text(
                  'Что-то пошло не так',
                  style: kAlertTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Text(message),
            actions: [
              FlatButton(
                child: const Text(
                  'ОК',
                  style: kAlertButtonTextStyle,
                ),
                color: kMainColor,
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
}
