import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/register_screen.dart';
import 'screens/sending_data_screen.dart';


void main() => runApp(DNSTestTask());

class DNSTestTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: kMainColor,
        ),
        home: RegisterScreen(),
        routes: {
          SendingDataScreenState.routeName: (context) => SendingDataScreen(),
        });
  }
}
