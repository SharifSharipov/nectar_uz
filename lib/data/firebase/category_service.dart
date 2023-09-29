import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nectar_uz/data/model/category/category.dart';
import '../model/universaldata.dart';
class CategoryService {
  Future<UniversalData> addCategory(
      {required CategoryModel categoryModel}) async {
    try {
      DocumentReference newCategoriy = await FirebaseFirestore.instance
          .collection('category')
          .add(categoryModel.toJson());
      await FirebaseFirestore.instance
          .collection('category')
          .doc(newCategoriy.id)
          .update({"catgoryId": newCategoriy.id});
      return UniversalData(data: "Category added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> uppdateCategory(
      {required CategoryModel categoryModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('category')
          .doc(categoryModel.categoryId)
          .update(categoryModel.toJson());
      return UniversalData(data: "Category uppdated");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> deleteCategory({required String categoryId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('category')
          .doc(categoryId)
          .delete();
      return UniversalData(data: "Category deledted");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }
}
