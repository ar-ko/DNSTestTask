import 'package:flutter/material.dart';
import '../Models/ScreenArguments.dart';

class SendingDataScreen extends StatelessWidget {
  static const routeName = '/extractArguments';
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Отправка данных',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            )),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 23, 16, 0),
                child: Column(
                  children: [
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Ссылка на github',
                        hintStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 29,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Ссылка на резюме',
                        hintStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 28, 0, 45),
                        child: RaisedButton(
                          child: Text('ЗАРЕГИСТРИРОВАТЬСЯ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            _registerButton(args);
                          },
                        ),
                      )))
            ],
          ),
        ));
  }

  _registerButton(ScreenArguments args) {
    var token = args.token;
    print(token);
  }
}
