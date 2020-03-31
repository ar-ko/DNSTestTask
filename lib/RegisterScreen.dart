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
        child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.fromLTRB(15, 23, 16, 0),
              child: _textFields()),
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
            hintText: 'E-mail',
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
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
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
            onPressed: () {},
            child: Text(
              'ПОЛУЧИТЬ КЛЮЧ',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ));
  }
}
