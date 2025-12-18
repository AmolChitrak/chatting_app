import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GooglesAuthProvider extends ChangeNotifier {
  bool loading = false;
  String? fullName;
  String? email;

  Future<bool> signInWithGoogle() async {
    try {
      loading = true;
      notifyListeners();

      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred =
      await FirebaseAuth.instance.signInWithCredential(credential);

      fullName = userCred.user?.displayName;
      email = userCred.user?.email;

      return true;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
