import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/background.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/DAO/credentials.dart';
import 'package:flutter_auth/DAO/credentials_dao.dart';
import 'dart:math';

class Body extends StatelessWidget {
  String username, password;
  bool validate = true;
  Random rand = Random();

  void onChanged(value) {
    password = value;
  }

  final credentials_dao = CredentialDao();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Firebase.initializeApp();
    return Background(
      Colo: Color.fromRGBO(0, 173, 239, .3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(
                  color: Color.fromRGBO(0, 173, 239, 1),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              color: Color.fromRGBO(0, 173, 239, 1),
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Phone Number",
              validate: validate,
              onChanged: (value) {
                username = value;
              },
            ),
            RoundedPasswordField(onChanged),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                int Balance = rand.nextInt(10001);
                String AccountNumber =
                    (10000).toString() + (rand.nextInt(100000000).toString());
                final credentials =
                    Credentials(username, password, AccountNumber, Balance);
                credentials_dao.saveCredentials(credentials);
                username.isEmpty ? validate = false : validate = true;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
