import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<User?> signInWithGoogle () async{
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null){
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    }catch(e){
      return null;
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    print('Log in signInWithFaceBook  accessToken ${loginResult.accessToken!.tokenString}');
    print('Log in signInWithFaceBook message ${loginResult.message}');
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    print('Log in signInWithFaceBook userCredential username' + userCredential.additionalUserInfo!.username.toString());
    print('Log in signInWithFaceBook userCredential email' + userCredential.user!.email.toString());
    print('Log in signInWithFaceBook userCredential photo' + userCredential.user!.photoURL.toString());
    return userCredential;
  }
  // Future<UserCredential?> signInWithFacebook() async {
  //   try {
  //     // Trigger the sign-in flow
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //     // Check if login was successful
  //     if (loginResult.status == LoginStatus.success) {
  //       // Create a credential from the access token
  //       final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
  //
  //       // Sign in with the credential
  //       final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //
  //       // Return the UserCredential
  //       return userCredential;
  //     } else {
  //       // Handle login failure
  //       print('Login failed: ${loginResult.message}');
  //       return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'account-exists-with-different-credential') {
  //       // Handle account exists with different credential error
  //       final String email = e.email!;
  //
  //       // Retrieve the sign-in methods for the email
  //       final List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //
  //       // Display an appropriate message or prompt user to sign in using the available methods
  //       print('Account exists with different credentials. Please sign in using a provider associated with this email address.');
  //
  //       // Prompt user to sign in using the method associated with their email or link accounts
  //     } else {
  //       // Handle other exceptions
  //       print('Error signing in with Facebook: ${e.message}');
  //     }
  //     return null;
  //   } catch (e) {
  //     // Handle other errors
  //     print('Error: $e');
  //     return null;
  //   }
  // }
  //

  Future<User?> createAccount(String email, String password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user;
    }catch(e)
    {
      if(e is FirebaseAuthException){
        if(e.code == 'email-already-in-use'){
          print('exeption create ----------------- ${e.code}');
          throw Exception('email-already-in-use');
        }else if(e.code == 'reCAPTCHA_FAILED'){
          throw Exception('reCAPTCHA_FAILED');
        }
      }
      return null;
    }
  }
  Future<void> deleteAccount(User? user) async {
    if (user != null) {
      try {
        await user.delete();
      } catch (e) {
        print('Error deleting account: $e');
      }
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
      print(e);
      if(e is FirebaseAuthException){
        if(e.code == 'user-not-found' || e.code == 'wrong-password' ||
            e.code == 'too-many-requests' ||
            e.code == 'account-exists-with-different-credential' || e.code == 'invalid-credential'){
          throw Exception(e.code);
        }
      }
    }
    return null;
  }

  Future<bool> updatePasswordForgot(String newPassword) async {
    try {
      User? user = _firebaseAuth.currentUser;
      await user?.updatePassword(newPassword);
      await user?.reload();
      return true;
      print('Password updated successfully.');
    } on FirebaseAuthException catch (e) {
      print('Failed to update password: ${e.message}');
      if (e.code == 'weak-password') {
        throw Exception('The new password is too weak.');
      } else if (e.code == 'requires-recent-login') {
        throw Exception('Please re-authenticate before updating the password.');
      } else {
        throw Exception(e.message);
      }
      return false;
    } catch (e) {
      print('An unexpected error occurred: $e');
      throw Exception('An unexpected error occurred. Please try again later.');
      return false;
    }
  }


  Future<bool> reAuthUser (String currentPassword) async{
    try{
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null){
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: currentPassword
        );
        await user.reauthenticateWithCredential(credential);
        return true;
      }
      return false;
    }catch(e){
      print('$e');
      return false;
    }
  }
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      print('Successfully signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}