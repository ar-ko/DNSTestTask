import 'package:dns_test_task/RegisterScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(DNSTestTask());

class DNSTestTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Отправка резюме в ДНС',
        theme: ThemeData(
          primaryColor: Color(0xffED8E00),
        ),
        home: RegisterScreen());
  }
}
