/*  int count;
  int totalPrice;
  String orderId;
  String productId;
  String userId;
  String orderStatus;
  String createdAt;
  String productName;
*/
import 'dart:convert';

class OrderModel {
  int count;
  int totalPrice;
  String orderId;
  String productId;
  String userId;
  String orderStatus;
  String createdAt;
  String productName;
  String orderImg;
  String orderCurrency;
  OrderModel(
      {required this.count,
      required this.totalPrice,
      required this.orderId,
      required this.productId,
      required this.userId,
      required this.orderStatus,
      required this.createdAt,
      required this.productName,
      required this.orderImg,
      required this.orderCurrency});

  OrderModel copyWith(
      {int? count,
      int? totalPrice,
      String? orderId,
      String? productId,
      String? userId,
      String? orderStatus,
      String? createdAt,
      String? productName,
      String? orderImg,
      String? orderCurrency}) {
    return OrderModel(
        count: count ?? this.count,
        totalPrice: totalPrice ?? this.totalPrice,
        orderId: orderId ?? this.orderId,
        productId: productId ?? this.productId,
        userId: userId ?? this.userId,
        orderStatus: orderStatus ?? this.orderStatus,
        createdAt: createdAt ?? this.createdAt,
        productName: productName ?? this.productName,
        orderImg: orderImg ?? this.orderImg,
        orderCurrency: orderCurrency ?? this.orderCurrency);
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        count: json['count'] as int ?? 0,
        totalPrice: json['totalPrice'] as int ?? 0,
        orderId: json['orderId'] as String ?? "",
        productId: json['productId'] as String ?? "",
        userId: json["userId"],
        orderStatus: json["orderStatus"] as String ?? "",
        createdAt: json["createdAt"] as String ?? "",
        productName: json["productName"] as String ?? "",
        orderImg: json["orderImg"] as String ?? "",
        orderCurrency: json['orderCurrency']as String ??"");
  }
  Map<String, dynamic> toJson() => {
        'count': count,
        'totalPrice': totalPrice,
        'orderId': orderId,
        'productId': productId,
        'userId': userId,
        'orderStatus': orderStatus,
        'createdAt': createdAt,
        'productName': productName,
        'orderImg': orderImg,
        'orderCurrency':orderCurrency
      };
  @override
  String toString() {
    return """
    'count':$count,
    'totalPrice':$totalPrice,
    'orderId':$orderId,
    'productId':$productId,
    'userId':$userId,
    'orderStatus':$orderStatus,
    'createdAt':$createdAt,
    'productName':$productName,
    'orderImg':$orderImg,
    'orderCurrency':$orderCurrency
       """;
  }
}
