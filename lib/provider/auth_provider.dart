import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nectar_uz/data/model/universaldata.dart';
import 'package:nectar_uz/utils/show_dialog.dart';
import 'package:nectar_uz/utils/show_error_message.dart';

import '../data/firebase/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.firebaseServices});
  final AutService firebaseServices;
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController userControler = TextEditingController();
  TextEditingController numberControler = TextEditingController();
  bool isLoading = false;
  bool isSign = false;
  User? user = FirebaseAuth.instance.currentUser;

  loginPressButton() {
    passwordControler.clear();
    emailControler.clear();
    userControler.clear();
  }

  signUpPressButton() {
    passwordControler.clear();
    emailControler.clear();
  }

  Stream<User?> listenAutenststate() =>
      FirebaseAuth.instance.authStateChanges();

  Future<void> login(BuildContext context) async {
    String email = emailControler.text;
    String password = passwordControler.text;
      showLoading(context: context);
     UniversalData universalData=  await firebaseServices.signUp(email: email, password: password);
     if(context.mounted){
       hideLoading(dialogContext: context);
     }
     if(universalData.error.isEmpty){
       if(context.mounted){
         showConfirmMessage(message: "User logged Up", context: context);
       }
       else if(context.mounted){
         showErrorMessage(message: universalData.error, context: context);
       }
     }

  }

  Future<void> signUp(BuildContext context) async {
    String email = emailControler.text;
    String password = passwordControler.text;

     showLoading(context: context);
     UniversalData universalData=await firebaseServices.signUp(email: email, password: password);
     if(context.mounted){
       print(universalData.data);
       hideLoading(dialogContext: context);
     }
    if(universalData.error.isEmpty){
      if(context.mounted){
        showConfirmMessage(message: "User signed Up", context: context);
      }
      else if(context.mounted){
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.signOut();
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      manageMessage(context, e.code);
      if (e.code == "week-passsword") {
        debugPrint("The password providedto week");
      } else if (e.code == "email-already-in-use") {
        debugPrint("The account already for that email");
      }
    } catch (e) {
      manageMessage(context, e.toString());
    }
  }

  manageMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    isLoading = false;
    notifyListeners();
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
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
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// Handle other error
}
