import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_uz/ui/tab_box_admin/explore_Screen_admin/widget/category_add.dart';
import 'package:nectar_uz/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../data/model/category/category.dart';
import '../../../provider/category_provayder.dart';
class ExpiloreScreen_admin extends StatefulWidget {
  const ExpiloreScreen_admin({super.key});

  @override
  State<ExpiloreScreen_admin> createState() => _ExpiloreScreen_adminState();
}

class _ExpiloreScreen_adminState extends State<ExpiloreScreen_admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:  AppColors.c_ffffff,
        elevation: 0,
        title: const Text("Categories Admin",
        style:  TextStyle(
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
                    return CategoryAddScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add,color: Colors.black,),
          ),
        ],
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
              children: List.generate(
                snapshot.data!.length,
                    (index) {
                  CategoryModel categoryModel = snapshot.data![index];
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(border: Border.all(color:  Colors.black)),
                      child: Image.network(
                        categoryModel.imageUrl,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    onLongPress: () {
                      context.read<CategoryProvider>().deleteCategory(
                        context: context,
                        categoryId: categoryModel.categoryId,
                      );
                    },
                    title: Text(categoryModel.categoryName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),),
                    subtitle: Text(categoryModel.description,style: TextStyle(color: Colors.black)),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CategoryAddScreen(
                                categoryModel: categoryModel,
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit,color: Colors.black,),
                    ),
                  );
                },
              ),
            )
                : const Center(child: Text("Empty!"));
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