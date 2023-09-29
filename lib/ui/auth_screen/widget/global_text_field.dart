import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors.dart';
class GlobalTextField extends StatelessWidget {
  GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.textAlign,
    this.obscureText = false,
    this.maxLine = 1,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  TextAlign textAlign;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.r,
              offset: const Offset(5, 5),
            )
          ]
      ),
      child: TextField(
        cursorColor: Color(0xFF4F8962),
        maxLines: maxLine,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.c_0C1A30,
            fontFamily: "DMSans"),
        textAlign: textAlign,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.c_ffffff,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.c_0C1A30,
              fontFamily: "DMSans"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: AppColors.c_ffffff),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.c_ffffff,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.c_ffffff,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.c_ffffff,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.c_ffffff,
            ),
          ),
        ),
      ),
    );
  }
}
