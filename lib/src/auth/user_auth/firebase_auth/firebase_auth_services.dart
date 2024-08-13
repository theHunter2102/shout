import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> createAccount(String email, String password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user;
    }catch(e)
    {
      print('Fail to create account');
      return null;
    }

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async
  {
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user;
    }catch(e)
    {
      print('Fail to create account');
      return null;
    }
  }

}