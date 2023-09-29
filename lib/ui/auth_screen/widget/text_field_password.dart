import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_uz/utils/app_colors.dart';

class GloballineTextFieldpassword extends StatefulWidget {
  GloballineTextFieldpassword({Key? key, required this.hintext, required this.controller})
      : super(key: key);

  final String hintext;
  final TextEditingController controller;

  @override
  _GloballineTextFieldpasswordState createState() =>
      _GloballineTextFieldpasswordState();
}

class _GloballineTextFieldpasswordState
    extends State<GloballineTextFieldpassword> {
  bool IsObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: IsObscure,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.4,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 0.4,
          ),
        ),
        focusedBorder: InputBorder.none,
        hintText: widget.hintext,
        hintStyle: TextStyle(color: Colors.black.withAlpha(100)),
        suffixIcon: IconButton(
          icon: Icon(IsObscure ? Icons.visibility_off : Icons.visibility,color: AppColors.c_030303,),
          onPressed: () {
            setState(() {
              IsObscure = !IsObscure;
            });
          },
        ),
      ),
    );
  }
}
