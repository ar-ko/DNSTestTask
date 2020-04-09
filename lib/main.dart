import 'package:flutter/material.dart';
import 'Screens/SendingDataScreen.dart';
import 'Screens/RegisterScreen.dart';

void main() => runApp(DNSTestTask());

class DNSTestTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xffED8E00),
        ),
        //home: RegisterScreen(),
        home: RegisterScreen(),
        routes: {
          SendingDataScreenState.routeName: (context) => SendingDataScreen(),
        });
  }
}
