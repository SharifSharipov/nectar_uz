import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nectar_uz/data/model/universaldata.dart';

class AutService {

  Stream<User?> listenAutenststate() =>
      FirebaseAuth.instance.authStateChanges();

  Future<UniversalData> login({required String email,required String password}) async {
    try {
    UserCredential userCredential=  await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    return UniversalData(data: userCredential);
    } on FirebaseAuthException catch (e) {
        return UniversalData(error:e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> signUp({required String email,required String password}) async {
    try {
      print(1);
    UserCredential userCredential= await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(2);

    return UniversalData(data: userCredential);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return UniversalData(error: e.code);
    } catch (e) {
          return UniversalData(error:e.toString());
    }
  }

  Future<UniversalData> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      return UniversalData(data: "User logget Out");
    } on FirebaseAuthException catch (e) {
      manageMessage(context, e.code);
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  manageMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

  Future<UniversalData> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return UniversalData(data: userCredential);
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

// Handle other error
}
