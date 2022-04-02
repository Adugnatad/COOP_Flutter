import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/DashBoard/component/body.dart';

class DashScreen extends StatelessWidget {
  final String username;

  DashScreen(this.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MakeDashboardItems(username),
    );
  }
}
