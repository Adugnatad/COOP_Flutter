import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'credentials.dart';

class CredentialDao {
  void saveCredentials(Credentials credentials) {
    Firebase.initializeApp();
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
    ref = ref.child(credentials.username.toString());
    ref.set(credentials.toJson());
    ref = FirebaseDatabase.instance.ref().child('Users');
  }
}
