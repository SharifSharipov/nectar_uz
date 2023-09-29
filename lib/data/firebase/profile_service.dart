import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/universaldata.dart';

class ProfileService {
  Future<UniversalData> uppdateUserEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      return UniversalData(data: "Updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> uppdateUserImage({required String imagePath}) async {
    try {
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(imagePath);
      return UniversalData(data: "Updated");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }
  Future<UniversalData>uppDateUserName({required String userName})async{
    try{
      await FirebaseAuth.instance.currentUser?.updateDisplayName(userName);
      return UniversalData(data: "Updated!");
    }on FirebaseException catch(e){
        return UniversalData(error: e.code);
    }catch(e){
      return UniversalData(error: e.toString());
    }
  }
}
