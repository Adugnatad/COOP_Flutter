import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<Body> {
  String BuyerPhoneNumber;
  String _Amount;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPhoneNumber2() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'To Phone NO',
        fillColor: kPrimaryColor,
      ),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required';
        } else {
          BuyerPhoneNumber = value;
        }
        return null;
      },
      onSaved: (String value) {
        BuyerPhoneNumber = value;
      },
    );
  }

  Widget _buildAmount() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Amount'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Amount is Required';
        } else {
          _Amount = value;
        }

        // if (!RegExp(r"/^\d+$/").hasMatch(value)) {
        //   return 'Please enter a valid Amount';
        // }

        return null;
      },
      onSaved: (String value) {
        _Amount = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'PIN Code'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        } else {
          _password = value;
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buy Airtime")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildPhoneNumber2(),
                _buildAmount(),
                _buildPassword(),
                SizedBox(height: 50),
                ElevatedButton(
                  child: Text(
                    'BUY',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    DatabaseReference ref = FirebaseDatabase.instance
                        .ref()
                        .child("Users/" + BuyerPhoneNumber);

                    DatabaseEvent event = await ref.once();
                    // print(event.snapshot.value);
                    Map<dynamic, dynamic> map = event.snapshot.value;
                    print(event.snapshot.value);
                    int buyerbalance = map.values.toList()[1];

                    int newBuyerBalance = buyerbalance - int.parse(_Amount);

                    await ref.update({
                      "balance": newBuyerBalance,
                    });

                    print(BuyerPhoneNumber);
                    print(_Amount);
                    print(_password);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
