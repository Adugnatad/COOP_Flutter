import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/DashBoard/component/body.dart';

class DashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MakeDashboardItems(),
    );
  }
}
