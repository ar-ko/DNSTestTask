import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
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
          child: Column(
            children: [
              Container(
                  //color: Colors.blueGrey,
                  margin: const EdgeInsets.fromLTRB(15, 23, 16, 0),
                  child: Column(
                    children: [
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: 'Имя',
                          hintStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: 'Фамилия',
                          hintStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: 'e-mail',
                          hintStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Телефон',
                          hintStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        'ПОЛУЧИТЬ КЛЮЧ',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    margin: const EdgeInsets.fromLTRB(0, 28, 0, 45),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
