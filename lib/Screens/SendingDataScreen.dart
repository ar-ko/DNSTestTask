import 'package:dns_test_task/Models/FullUserData.dart';
import 'package:flutter/material.dart';
import '../Network/NetworkService.dart';
import '../Models/ScreenArguments.dart';
import '../Models/ServerResponse.dart';
import '../Models/ValidateForm.dart';

class SendingDataScreen extends StatelessWidget {
  static const routeName = '/extractArguments';
  final _focusSummaryUrl = FocusNode();

  final _githubProfileUrlController = TextEditingController();
  final _summaryUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments arguments = ModalRoute.of(context).settings.arguments;
    final _formKey = GlobalKey<FormState>();
    final ValidateForm _validateForm = ValidateForm();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Отправка данных',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 23, 16, 23),
                  child: Column(
                    children: [
                      TextFormField(
                          autovalidate: true,
                          controller: _githubProfileUrlController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Ссылка на github',
                            hintStyle: TextStyle(fontSize: 16),
                          ),
                          validator: _validateForm.validateGithub,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(_focusSummaryUrl);
                          }),
                      SizedBox(
                        height: 29,
                      ),
                      TextFormField(
                          autovalidate: true,
                          focusNode: _focusSummaryUrl,
                          controller: _summaryUrlController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Ссылка на резюме',
                            hintStyle: TextStyle(fontSize: 16),
                          ),
                          validator: _validateForm.validateURL,
                          onFieldSubmitted: (v) {
                            _registerButton(arguments, context);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
            height: 36,
            width: 160,
            margin: const EdgeInsets.only(bottom: 45),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  _registerButton(arguments, context);
                },
                child: Text(
                  'ЗАРЕГИСТРИРОВАТЬСЯ',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
            )),
      ),
    );
  }

  void _registerButton(ScreenArguments arguments, BuildContext context) {
    final FullUserData user = FullUserData(
        user: arguments.user,
        githubProfileUrl: _githubProfileUrlController.text,
        summaryUrl: _summaryUrlController.text);

    void _showDialog(BuildContext context, ServerResponse response) {
      if (response.code == 0) {
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
              ),
              actions: [
                FlatButton(
                  child: Text('ОК'),
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
                  ),
                  Text(
                    'Что-то пошло не так',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              content: Text(response.message),
              actions: [
                FlatButton(
                  child: Text('ОК'),
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

    void _register(BuildContext context) async {
      var json =
          await NetworkService().registerCandidate(user, arguments.token);
      var response = ServerResponse.fromJson(json);
      /*if (response.code == 0) {
        _showDialog(context, response);
      } else {
        print(response.message);
      }*/
      _showDialog(context, response);
    }

    _register(context);
  }
}
