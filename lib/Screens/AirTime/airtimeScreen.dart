import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Airtime/components/body.dart';

class AirtimeScreen extends StatelessWidget {
  final String username;
  AirtimeScreen(this.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(username),
    );
  }
}
