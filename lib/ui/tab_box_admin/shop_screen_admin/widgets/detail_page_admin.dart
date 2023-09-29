import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar_uz/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/order/order_model.dart';
import '../../../../data/model/product/product_model.dart';
import '../../../../provider/order_provider.dart';
import '../../../auth_screen/widget/global_button.dart';

class ProductDetailScreen_admin extends StatefulWidget {
  const ProductDetailScreen_admin(
      {super.key, required this.productModel, required this.index});

  final ProductModel productModel;
  final int index;

  @override
  State<ProductDetailScreen_admin> createState() =>
      _ProductDetailScreen_adminState();
}

class _ProductDetailScreen_adminState extends State<ProductDetailScreen_admin> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product",
          style: TextStyle(
              fontSize: 20.spMin,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ScrollPhysics(),
                children: [
                  Hero(
                    tag: widget.index,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: CachedNetworkImage(
                        height: 250.h,
                        width: 250.h,
                        imageUrl: widget.productModel.productImages.first,
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    widget.productModel.productName,
                    style: TextStyle(
                        fontSize: 32.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    widget.productModel.description,
                    style: TextStyle(
                        fontSize: 22.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Count: ${widget.productModel.count}",
                    style: TextStyle(
                        fontSize: 22.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Price: ${widget.productModel.price} ${widget.productModel.currency}",
                    style: TextStyle(
                        fontSize: 22.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (count > 1) {
                            setState(() {
                              count--;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.remove,
                        ),
                      ),
                      Text(
                        count.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {
                            if ((count + 1) <= widget.productModel.count) {
                              setState(() {
                                count++;
                              });
                            }
                          },
                          child: const Icon(Icons.add)),
                    ],
                  ),
                  Text(
                    "Total price: ${widget.productModel.price * count}.   ${widget.productModel.currency}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            GlobalButton(
              onTap: () {
                Provider.of<OrderProvider>(context, listen: false).addOrder(
                  context: context,
                  orderModel: OrderModel(
                    count: count,
                    totalPrice: widget.productModel.price * count,
                    orderId: "",
                    productId: widget.productModel.productId,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    orderStatus: "ordered",
                    createdAt: DateTime.now().toString(),
                    productName: widget.productModel.productName,
                    orderImg: '',
                    orderCurrency: widget.productModel.currency,
                  ),
                );
              },
              title: "Add to Card",
              color: AppColors.c_01AA4F,
            )
          ],
        ),
      ),
    );
  }
}
