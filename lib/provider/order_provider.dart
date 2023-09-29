import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/firebase/order_service.dart';
import '../data/model/order/order_model.dart';
import '../data/model/universaldata.dart';
import '../utils/show_dialog.dart';

class OrderProvider with ChangeNotifier {
  OrderProvider({required this.orderService}) {
    listenOrders(FirebaseAuth.instance.currentUser!.uid);
  }

  final OrderService orderService;
  List<OrderModel> userOrders = [];

  Future<void> addOrder({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    List<OrderModel> exists = userOrders
        .where((element) => element.productId == orderModel.productId)
        .toList();

    OrderModel? oldOrderModel;
    if (exists.isNotEmpty) {
      oldOrderModel = exists.first;
      oldOrderModel = oldOrderModel.copyWith(
          count: orderModel.count + oldOrderModel.count,
          totalPrice:
          (orderModel.count + oldOrderModel.count) * orderModel.totalPrice);
    }

    showLoading(context: context);
    UniversalData universalData = exists.isNotEmpty
        ? await orderService.updateOrder(orderModel: oldOrderModel!)
        : await orderService.addOrder(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
        Navigator.pop(context);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateOrder({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    showLoading(context: context);

    UniversalData universalData =
    await orderService.updateOrder(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> deleteOrder({
    required BuildContext context,
    required String orderId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
    await orderService.deleteOrder(orderId: orderId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<OrderModel>> listenOrdersList(String? uid) async* {
    if (uid == null) {
      yield* FirebaseFirestore.instance.collection("orders").snapshots().map(
            (event1) =>
            event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
      );
    } else {
      yield* FirebaseFirestore.instance
          .collection("orders")
          .where("userId", isEqualTo: uid)
          .snapshots()
          .map(
            (event1) =>
            event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
      );
    }
  }
  Stream<List<OrderModel>> getOrdersByUIDWaiting(
      String userId,
      ) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('userId', isEqualTo: userId)
        .where('orderStatus', isEqualTo: "waiting")

        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList(),
    );
  }
  Stream<List<OrderModel>> getOrdersUID(String uID) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('userId', isEqualTo: uID)
        .orderBy('createdAt')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => OrderModel.fromJson(doc.data()))
        .toList());
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(microseconds: 1000), content: Text(error)));
    notifyListeners();
  }

  Stream<List<OrderModel>> getOrdersByOrdered(
      String userId,
      ) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('orderStatus', isEqualTo: "Ordered")
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList(),
    );
  }
  Stream<List<OrderModel>> getOrdersByOrderID(String orderId) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('orderId', isEqualTo: orderId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => OrderModel.fromJson(doc.data()))
        .toList());
  }
  Stream<List<OrderModel>> getOrdersByUICanceled(
      String userId,
      ) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('userId', isEqualTo: userId)
        .where('orderStatus', isEqualTo: "Canceled")

        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList(),
    );
  }
  Future updateByOrderField(
      {required String collectionName,
        required String collectionDocId,
        required String docField,
        required updatedText}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(collectionDocId)
        .update({
      docField: updatedText,
    });
  }
  listenOrders(String userId) async {
    listenOrdersList(userId).listen((List<OrderModel> orders) {
      userOrders = orders;
      debugPrint("CURRENT USER ORDERS LENGTH:${userOrders.length}");
      notifyListeners();
    });
  }
  Stream<List<OrderModel>> getOrdersByUIShipping(
      String userId,
      ) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('userId', isEqualTo: userId)
        .where('orderStatus', isEqualTo: "Delivering")

        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList(),
    );
  }




}

