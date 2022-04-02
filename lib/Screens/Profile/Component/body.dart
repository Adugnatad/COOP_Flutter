import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class Body extends StatelessWidget {
  final String username;
  String AccountNumber;
  String Balance;
  String PhoneNumber;
  final _accountController = TextEditingController();
  final _phoneController = TextEditingController();
  final _balanceController = TextEditingController();

  void getData() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child("Users/" + username);
    DatabaseEvent event = await ref.once();
    print(event.snapshot.value);
    Map<dynamic, dynamic> map = event.snapshot.value;
    AccountNumber = (map.values.toList()[2]).toString();
    Balance = (map.values.toList()[1]).toString();
    PhoneNumber = (map.values.toList()[3]).toString();
    _accountController.text = AccountNumber;
    _phoneController.text = PhoneNumber;
    _balanceController.text = Balance + " ETB";
    // Balance = (map.values.toList()[0]).toString();
    // PhoneNumber = (map.values.toList()[0]).toString();
  }

  Body(this.username) {
    getData();
  }

  Widget _buildAccountNumber() {
    return TextFormField(
      controller: _accountController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Account Number",
        fillColor: kPrimaryColor,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 20,
      validator: (String value) {
        // value = "hello";
        return null;
      },
    );
  }

  Widget _buildBalance() {
    return TextFormField(
      controller: _balanceController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Balance",
        fillColor: kPrimaryColor,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 10,
      validator: (String value) {
        value = Balance;
        return null;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      controller: _phoneController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Phone Number",
        fillColor: kPrimaryColor,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 10,
      validator: (String value) {
        value = PhoneNumber;
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 173, 239, .3),
      appBar: AppBar(title: Text("User Profile")),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              _buildAccountNumber(),
              _buildPhoneNumber(),
              _buildBalance(),
            ],
          ),
        ],
      ),
    );
  }
}
