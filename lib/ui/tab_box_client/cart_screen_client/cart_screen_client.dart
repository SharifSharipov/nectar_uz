import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nectar_uz/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../data/model/order/order_model.dart';
import '../../../provider/order_provider.dart';

class CartScreen_client extends StatefulWidget {
  const CartScreen_client({
    super.key,
  });

  @override
  State<CartScreen_client> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<CartScreen_client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_ffffff,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_ffffff,
        title: const Text(
          "Cart Screen",
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Gilroy',
              color: AppColors.c_030303),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: context
            .read<OrderProvider>()
            .listenOrdersList(FirebaseAuth.instance.currentUser!.uid),
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 18, left: 10, right: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 3,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        OrderModel orderModel = snapshot.data![index];
                        return Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade300,
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(
                                      18,
                                    ),
                                    topRight: Radius.circular(
                                      18,
                                    )),
                                child: SizedBox(
                                    height: 180,
                                    width: 200,
                                    child: CachedNetworkImage(
                                        imageUrl: orderModel.orderImg,
                                        placeholder: (context, url) =>
                                            const CupertinoActivityIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    orderModel.productName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Price: ${orderModel.totalPrice} ${orderModel.orderCurrency}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.c_030303,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Count: ${orderModel.count}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: AppColors.c_030303,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: LottieBuilder.asset("assets/lottie/empty_box.json"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
