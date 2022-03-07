import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/components/rounded_button.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  String value;
  bool validate;
  final IconData icon;
  final ValueChanged<String> onChanged;
  TextEditingController textcontroller = new TextEditingController();
  RoundedInputField({
    Key key,
    this.hintText,
    this.validate,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: textcontroller,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          errorText: validate ? null : 'Username Can\'t Be Empty',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
