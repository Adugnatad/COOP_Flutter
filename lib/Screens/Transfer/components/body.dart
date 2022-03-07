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
  String SenderPhoneNumber;
  String ReceiverPhoneNumber;
  String _Amount;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Receiver Phone NO',
        fillColor: kPrimaryColor,
      ),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required';
        } else {
          ReceiverPhoneNumber = value;
        }
        return null;
      },
      onSaved: (String value) {
        ReceiverPhoneNumber = value;
      },
    );
  }

  Widget _buildPhoneNumber2() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Sender Phone NO',
        fillColor: kPrimaryColor,
      ),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required';
        } else {
          SenderPhoneNumber = value;
        }
        return null;
      },
      onSaved: (String value) {
        SenderPhoneNumber = value;
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
      appBar: AppBar(title: Text("Transfer Money")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildPhoneNumber2(),
                _buildPhoneNumber(),
                _buildAmount(),
                _buildPassword(),
                SizedBox(height: 50),
                ElevatedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    DatabaseReference ref = FirebaseDatabase.instance
                        .ref()
                        .child("Users/" + SenderPhoneNumber);

                    DatabaseEvent event = await ref.once();
                    // print(event.snapshot.value);
                    Map<dynamic, dynamic> map = event.snapshot.value;
                    print(event.snapshot.value);
                    int senderamount = int.parse(map.values.toList()[1]);

                    ref = FirebaseDatabase.instance
                        .ref()
                        .child("Users/" + ReceiverPhoneNumber);

                    event = await ref.once();
                    map = event.snapshot.value;

                    int receiveramount = int.parse(map.values.toList()[1]);

                    int senderamountremaining =
                        senderamount - int.parse(_Amount);

                    int receiveramountremaining =
                        receiveramount + int.parse(_Amount);
                    //calculations

                    await ref.update({
                      "balance": receiveramountremaining,
                    });

                    ref = FirebaseDatabase.instance
                        .ref()
                        .child("Users/" + SenderPhoneNumber);
                    event = await ref.once();
                    map = event.snapshot.value;
                    await ref.update({
                      "balance": senderamountremaining,
                    });

                    print(SenderPhoneNumber);
                    print(_Amount);
                    print(_password);

                    //Send to API
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
