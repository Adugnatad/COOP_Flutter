import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Profile/Component/body.dart';

class profileScreen extends StatelessWidget {
  final String username;
  profileScreen(this.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(username),
    );
  }
}
