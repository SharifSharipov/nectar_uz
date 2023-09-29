import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/model/product/product_model.dart';
import '../../../utils/app_colors.dart';
import '../shop_screen_client/widgets/search_screen.dart';

class ExpiloreScreen_client extends StatefulWidget {
  const ExpiloreScreen_client({super.key});

  @override
  State<ExpiloreScreen_client> createState() => _ExpiloreScreen_clientState();
}

class _ExpiloreScreen_clientState extends State<ExpiloreScreen_client> {
  TextEditingController _searchController = TextEditingController();
  List<ProductModel> _productList = []; // Your actual product list
  List<ProductModel> _filteredProductList = [];

  @override
  void initState() {
    super.initState();
    _filteredProductList = _productList;
    _searchController.addListener(_searchProduct);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _searchProduct() {
    String searchText = _searchController.text;
    if (searchText.isEmpty) {
      setState(() {
        _filteredProductList = _productList;
      });
    } else {
      List<ProductModel> tempProductList = [];
      for (var product in _productList) {
        if (product.productName
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          tempProductList.add(product);
        }
      }
      setState(() {
        _filteredProductList = tempProductList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_ffffff,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_ffffff,
        title: const Text('Find Products',style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Gilroy',
            color: AppColors.c_030303),),
         centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration:  InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  hintText: "Search Store",
                  hintStyle:const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Gilroy',
                      color: Colors.black) ,
                  helperStyle: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Gilroy',
                      color: Colors.black),
                  suffixIcon: IconButton(
                    onPressed: () { showSearch(context: context, delegate: ProductsSearchDelegate());},
                    icon: const Icon(Icons.search, color: Colors.grey),
                  ),

                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Change the color to your preference
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.6),
                children: [
                  ...List.generate(_filteredProductList.length, (index) {
                    ProductModel productModel = _filteredProductList[index];
                    return ZoomTapAnimation(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blue.withOpacity(0.8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: index,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  height: 100,
                                  width: 100,
                                  imageUrl: productModel.productImages.first,
                                  placeholder: (context, url) =>
                                      const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  productModel.productName,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  productModel.description,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Price: ${productModel.price} ${productModel.currency}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Count: ${productModel.count}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
