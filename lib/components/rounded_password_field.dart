import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  RoundedPasswordField(this.onChanged);
  @override
  RoundedPasswordFieldState createState() =>
      RoundedPasswordFieldState(onChanged);
}

class RoundedPasswordFieldState extends State<RoundedPasswordField> {
  final ValueChanged<String> onChanged;
  bool obscure = true;
  var _passwordController = TextEditingController();
  RoundedPasswordFieldState(
    this.onChanged,
  );

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: _passwordController,
        obscureText: obscure,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Color.fromRGBO(0, 173, 239, 1),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscure = !obscure;
              });
            },
            icon: !obscure
                ? Icon(
                    Icons.visibility,
                    color: Color.fromRGBO(0, 173, 239, 1),
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Color.fromRGBO(0, 173, 239, 1),
                  ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
