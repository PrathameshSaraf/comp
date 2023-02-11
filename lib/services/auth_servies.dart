import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Common/AuthExceptionHandler.dart';
class AuthServices {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logout(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, "/admin", (route) => false);
    });
  }


  Future<bool> checkIfEmailInUse(String? emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress!);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }


  bool isUserLoggedIn(BuildContext context) {
    try {
      if (_auth.currentUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return false;
    }
  }

  String getEmail() {
    if (_auth.currentUser == null) {
      return "";
    } else {
      return _auth.currentUser!.email ?? "";
    }
  }

    Future<User?> registerUsingEmailPassword(
     String name, String email, String password ) async {

    User? user;
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  AuthStatus? _status;
  Future<AuthStatus> resetPassword({required String email}) async {
   print(email);
    await _auth.sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status!;
  }
 }
