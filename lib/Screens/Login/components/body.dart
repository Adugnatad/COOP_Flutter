import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
// import 'package:flutter_auth/Screens/Transfer/balanceScreen.dart';
import 'package:flutter_auth/Screens/DashBoard/Data/dashboardScreen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatelessWidget {
  String username, password;
  bool validate = true;
  Body({
    Key key,
  }) : super(key: key);

  void onChanged(value) {
    password = value;
  }

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
              "LOGIN",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              color: Color.fromRGBO(0, 173, 239, 1),
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Phone Number",
              validate: validate,
              onChanged: (value) {
                username = value;
              },
            ),
            RoundedPasswordField(onChanged),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                DatabaseReference ref =
                    FirebaseDatabase.instance.ref().child("Users/" + username);

                DatabaseEvent event = await ref.once();
                print(event.snapshot.value);
                Map<dynamic, dynamic> map = event.snapshot.value;
                String passwordReturned = (map.values.toList()[0]).toString();
                print(passwordReturned);

                if (password == passwordReturned) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // return BalanceScreen();
                        return DashScreen(username);
                      },
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: 'Incorrect Password',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.orange);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
