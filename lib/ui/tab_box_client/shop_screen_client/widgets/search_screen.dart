import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../data/model/product/product_model.dart';
import '../../../../provider/product_provayder.dart';
import '../../../../utils/app_colors.dart';

class ProductsSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text('Search is not implemented yet.'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_ffffff,
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsProvider>().getProducts(''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data.'),
            );
          } else {
            final List<ProductModel> productList = snapshot.data!;
            final List<ProductModel> suggestionList = query.isEmpty
                ? productList
                : productList
                    .where((product) => product.productName
                        .toLowerCase()
                        .startsWith(query.toLowerCase()))
                    .toList();

            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.6),
              children: [
                ...List.generate(suggestionList.length, (index) {
                  ProductModel productModel = suggestionList[index];
                  return ZoomTapAnimation(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.shade300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            child: Hero(
                              tag: index,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  height: 200,
                                  fit: BoxFit.cover,
                                  imageUrl: productModel.productImages.first,
                                  placeholder: (context, url) =>
                                      const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                    ),
                  );
                })
              ],
            );
          }
        },
      ),
    );
  }
}
