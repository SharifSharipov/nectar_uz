import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_uz/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../data/model/product/product_model.dart';
import '../../../provider/product_provayder.dart';
import '../explore_Screen_admin/widget/product_screen_admin.dart';

class ShopScreen_admin extends StatefulWidget {
  const ShopScreen_admin({super.key});

  @override
  State<ShopScreen_admin> createState() => _ShopScreen_adminState();
}

class _ShopScreen_adminState extends State<ShopScreen_admin> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // AppBar code here
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.c_ffffff,
        title: const Text(
          "Shopscreen Admin",
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Gilroy',
              color: AppColors.c_030303),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductAddScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add,color: AppColors.c_030303,),
          )
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsProvider>().getProducts(""),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 3,
                childAspectRatio: 0.6,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                ProductModel productModel = snapshot.data![index];
                return Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                  height: deviceHeight * 0.5,
                  width: deviceWidth * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color:Colors.grey.shade300,
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(18,),topRight: Radius.circular(18,) ),
                        child: SizedBox(
                          height: 180,
                          width: 200,
                            child: CachedNetworkImage(
                              imageUrl: productModel.productImages.first,
                              placeholder: (context, url) => const CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.cover)
                        ),
                      ),
                      const SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Text(
                      productModel.productName,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Price: ${productModel.price} ${productModel.currency}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.c_030303,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],),
                      const SizedBox(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            productModel.description,
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.c_030303,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Price: ${productModel.price} ${productModel.currency}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.c_030303,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Count: ${productModel.count}",
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
                );
              },
            )
                : const Center(child: Text("Product Empty!"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      backgroundColor: Colors.white,
    );

  }
}
