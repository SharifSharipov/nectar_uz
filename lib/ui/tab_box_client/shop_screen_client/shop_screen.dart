import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_uz/ui/tab_box_client/shop_screen_client/widgets/catgory_iteam.dart';
import 'package:nectar_uz/ui/tab_box_client/shop_screen_client/widgets/detail_page.dart';
import 'package:nectar_uz/ui/tab_box_client/shop_screen_client/widgets/search_screen.dart';
import 'package:nectar_uz/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/model/category/category.dart';
import '../../../data/model/product/product_model.dart';
import '../../../provider/category_provayder.dart';
import '../../../provider/product_provayder.dart';

class ShopScreen_client extends StatefulWidget {
  const ShopScreen_client({super.key});
  @override
  State<ShopScreen_client> createState() => _ShopScreen_clientState();
}
class _ShopScreen_clientState extends State<ShopScreen_client> {
  String selectedCategoryId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_ffffff,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Shop screen",style: TextStyle(
        fontStyle: FontStyle.normal,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Gilroy',
            color: AppColors.c_030303),),
        centerTitle: true,
        backgroundColor: AppColors.c_ffffff,
        actions: [
          IconButton(onPressed: (){
             showSearch(context: context, delegate: ProductsSearchDelegate());
          }, icon: Icon(Icons.search,color: AppColors.c_030303,size: 35,))
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<List<CategoryModel>>(
            stream: context.read<CategoryProvider>().getCategories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryItemView(
                        categoryModel: CategoryModel(
                          categoryId: "",
                          description: "",
                          categoryName: "All",
                          imageUrl: "",
                          createdAt: "",
                        ),
                        onTap: () {
                          setState(() {
                            selectedCategoryId = "";
                          });
                        },
                        selectedId: selectedCategoryId,
                      ),
                      ...List.generate(
                        snapshot.data!.length,
                            (index) {
                          CategoryModel categoryModel =
                          snapshot.data![index];
                          return CategoryItemView(
                            categoryModel: categoryModel,
                            onTap: () {
                              setState(() {
                                selectedCategoryId =
                                    categoryModel.categoryId;
                              });
                            },
                            selectedId: selectedCategoryId,
                          );
                        },
                      )
                    ],
                  ),
                )
                    : const Center(child: Text("Empty!",style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy',
                    color: AppColors.c_030303)));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          StreamBuilder<List<ProductModel>>(
            stream: context
                .read<ProductsProvider>()
                .getProducts(selectedCategoryId),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: StreamBuilder<List<ProductModel>>(
                            stream: context
                                .read<ProductsProvider>()
                                .getProducts(selectedCategoryId),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ProductModel>> snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.isNotEmpty
                                    ? Expanded(
                                        child: GridView(

                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                childAspectRatio: 0.6),
                                        children: [
                                          ...List.generate(
                                              snapshot.data!.length, (index) {
                                            ProductModel productModel =
                                                snapshot.data![index];
                                            return ZoomTapAnimation(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailScreen(
                                                      productModel:
                                                          productModel,
                                                      index: index,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color:Colors.grey.shade300,),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height:175,
                                                      width: 175,
                                                      child: Hero(
                                                        tag: index,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          child:
                                                              CachedNetworkImage(
                                                            height:175,
                                                            fit: BoxFit.cover,
                                                            //width: 175,
                                                            imageUrl: productModel
                                                                .productImages
                                                                .first,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CupertinoActivityIndicator(),
                                                            errorWidget: (context,
                                                                    url, error) =>
                                                                const Icon(
                                                                    Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Text(
                                                              productModel
                                                                  .productName,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  color:
                                                                  AppColors.c_162023,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                              "Price: ${productModel.price} ${productModel.currency}",
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color:AppColors.c_162023,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Text(
                                                          productModel
                                                              .description,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                              AppColors.c_162023,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Text(
                                                          "Count: ${productModel.count}",
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                              AppColors.c_162023,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                        ],
                                      ))
                                    : const Center(
                                        child: Text(
                                          "Product Empty!",
                                          style: TextStyle(
                                              fontSize: 32,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
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
        ],
      ),
    );
  }
}
