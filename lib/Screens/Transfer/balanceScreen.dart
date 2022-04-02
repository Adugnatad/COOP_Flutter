import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Transfer/components/body.dart';

class BalanceScreen extends StatelessWidget {
  final String username;

  BalanceScreen(this.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(username),
    );
  }
}
