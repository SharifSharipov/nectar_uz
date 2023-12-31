import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/category/category.dart';
import '../../../../provider/category_provayder.dart';
import '../../../../utils/app_colors.dart';
import '../../../auth_screen/widget/global_button.dart';
import '../../../auth_screen/widget/global_text_field.dart';

class CategoryAddScreen extends StatefulWidget {
  CategoryAddScreen({super.key, this.categoryModel});

  CategoryModel? categoryModel;

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    if (widget.categoryModel != null) {
      context.read<CategoryProvider>().setInitialValues(widget.categoryModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CategoryProvider>(context, listen: false).clearTexts();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.c_ffffff,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.c_ffffff,
          title: Text(widget.categoryModel == null
              ? "Category Add"
              : "Category Update",style: const TextStyle(color:AppColors.c_0C1A30,),),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.c_0C1A30,
            ),
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false)
                  .clearTexts();
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  GlobalTextField(
                      hintText: "Name",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<CategoryProvider>()
                          .categoryNameController, ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 200,
                    child: GlobalTextField(
                        maxLine: 100,
                        hintText: "Description",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<CategoryProvider>()
                            .categoryDescController, ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 130,
                    height: 150,
                    child: TextButton(
                      onPressed: () {
                        showBottomSheetDialog();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).indicatorColor),
                      child: context
                          .watch<CategoryProvider>()
                          .categoryUrl
                          .isEmpty
                          ? const Text(
                        "Image Not Selected",
                        style: TextStyle(color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                          : Image.network(
                          context.watch<CategoryProvider>().categoryUrl),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 8,bottom: 8),
              child: GlobalButton(
                  title: widget.categoryModel == null
                      ? "Add category"
                      : "Update Category",
                  onTap: () {
                    if (widget.categoryModel == null) {
                      context.read<CategoryProvider>().addCategory(
                        context: context,
                      );
                    } else {
                      context.read<CategoryProvider>().updateCategory(
                          context: context,
                          currentCategory: widget.categoryModel!);
                    }
                  }, color:AppColors.c_858585,),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null) {
      print("VBNKM<");
      await Provider.of<CategoryProvider>(context,listen: false)
          .uploadCategoryImage(context, xFile);

    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      await Provider.of<CategoryProvider>(context,listen: false)
          .uploadCategoryImage(context, xFile);
    }
  }
}