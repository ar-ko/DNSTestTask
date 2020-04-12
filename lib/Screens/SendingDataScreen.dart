import 'package:flutter/material.dart';
import '../Models/ScreenArguments.dart';
import '../Models/ServerResponse.dart';
import '../Models/ValidateForm.dart';
import '../Models/FullUserData.dart';

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
    final ScreenArguments arguments = ModalRoute.of(context).settings.arguments;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Отправка данных',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            )),
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
                        _gihubURLForm(),
                        SizedBox(height: 29),
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
        decoration: const InputDecoration(
          hintText: 'Ссылка на github',
          hintStyle: TextStyle(fontSize: 16),
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
        decoration: const InputDecoration(
          hintText: 'Ссылка на резюме',
          hintStyle: TextStyle(fontSize: 16),
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
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
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
    final response = await user.register(arguments.token, user);
    setState(() {
      _isLoading = false;
    });
    _showDialog(response);
  }

  void _showDialog(ServerResponse response) {
    String message;
    if (response == null)
      message = 'Отсутствует соединение с Интеренетом';
    else
      message = response.message;

    if (response != null && response.code == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Заявка успешно отправлена',
              textAlign: TextAlign.center,
            ),
            content: Icon(
              Icons.done,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
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
    } else {
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
                  style: TextStyle(fontSize: 18, color: Colors.black),
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
}
