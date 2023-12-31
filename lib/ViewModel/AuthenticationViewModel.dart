import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'AppState.dart';

import '../Controllers/ReportsController.dart';

class AuthenticationViewModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthenticationViewModel._();

  static final AuthenticationViewModel instance = AuthenticationViewModel._();
  // Singleton implementation
  factory AuthenticationViewModel() => instance;

  Future<User?> signUp(String email, String password) async {
    final ReportsController report = ReportsController();
    report.sendUserRegistrationLocation(email);
    try {
      if (await isEmailAlreadyUsed(email)) {
        return null;
      }

      final UserCredential currentUser =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return currentUser.user;
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'Invalid email address format.';
            break;
          case 'weak-password':
            errorMessage = 'The password is too weak.';
            break;
          default:
            errorMessage = 'An error occurred during registration.';
        }
      } else {
        errorMessage = 'An error occurred during registration.';
      }
      notifyListeners();
    }
    return null;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      String authError;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            authError = 'No user found for that email.';
            break;
          case 'wrong-password':
            authError = 'Wrong password provided for that user.';
            break;
          case 'invalid-email':
            authError = 'Invalid email address format.';
            break;
          default:
            authError = 'An error occurred during authentication.';
        }
      } else {
        authError = 'An error occurred during authentication.';
      }
      // Set the authError in your ViewModel for the UI to display
      print(authError);
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<bool> isEmailAlreadyUsed(String email) async {
    final List<String> signInMethods =
        await auth.fetchSignInMethodsForEmail(email);
    if (signInMethods.isNotEmpty) {
      return true;
    }
    return false;
  }

  User? get currentUser => auth.currentUser;
}
