import 'package:flutter/material.dart';
//import 'SendingDataScreen.dart';
import 'RegisterScreen.dart';

void main() => runApp(DNSTestTask());

class DNSTestTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xffED8E00),
        ),
        home: RegisterScreen());
  }
}
