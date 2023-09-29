import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar_uz/data/model/universaldata.dart';
import 'package:nectar_uz/utils/show_dialog.dart';

import '../data/firebase/profile_service.dart';

class ProfileProvider with ChangeNotifier {
  ProfileProvider({required this.profileService}) {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
    listenUserChanges();
  }

  final ProfileService profileService;
  TextEditingController nameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool iSloading = false;
  User? currentUser;

  notify(bool value) {
    iSloading = false;
    notifyListeners();
  }

  showMassage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notify(false);
  }

  listenUserChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }

  Future<void> updateUserImage(BuildContext context, String imagePath) async {
    showLoading(context: context);
    UniversalData universalData =
        await profileService.uppdateUserImage(imagePath: imagePath);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    } else if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMassage(context, universalData.error as String);
      } else {
        if (context.mounted) {
          showMassage(context, universalData.error);
        }
      }
    }
  }
  Future<void>uppdateUsername(BuildContext context,)async{
    String name=nameController.text;
    showLoading(context: context);
    UniversalData universalData=await profileService.uppDateUserName(userName: name);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }else if(universalData.error.isEmpty){
      if(context.mounted){
        showMassage(context,universalData.data as String);
      }
      else {
        if(context.mounted){
          showMassage(context, universalData.error);
        }
      }
    }
  }
  Future<void>updateEmail(BuildContext context)async{
    String email=emailController.text;
    showLoading(context: context);
    UniversalData universalData=await profileService.uppdateUserEmail(email: email);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }else if(universalData.error.isEmpty){
      if(context.mounted){
        showMassage(context, universalData.error as String);
      }else{
        if(context.mounted){
          showMassage(context,universalData.error);
        }
      }
    }
  }
}
