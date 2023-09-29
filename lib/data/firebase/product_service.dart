import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nectar_uz/data/model/product/product_model.dart';

import '../model/universaldata.dart';

class ProductServices {
  Future<UniversalData> addProduct({required ProductModel productModel}) async {
    try {
      DocumentReference newProduct = await FirebaseFirestore.instance
          .collection('products')
          .add(productModel.toJson());
      await FirebaseFirestore.instance
          .collection('products')
          .doc(newProduct.id)
          .update({'products': newProduct.id});
      return UniversalData(data: "Product added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData>updateProduct(
      {required ProductModel productModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productModel.productId)
          .update(productModel.toJson());
      return UniversalData(data: "Product update");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (e) {
      return UniversalData(error: e.toString());
    }
  }
  Future<UniversalData>deleteProduct({required String productId})async{
    try{
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      return UniversalData(data: "Delete product");
    }on FirebaseException catch(e){
      return UniversalData(error: e.toString());
    }catch(e){
      return UniversalData(error: e.toString());
    }
  }
}
