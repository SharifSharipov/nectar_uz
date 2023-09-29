import 'package:flutter/material.dart';
class GloballineTextField extends StatelessWidget {
  GloballineTextField({super.key, required this.hintext, required this.controller});
   final String hintext;
   final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller,
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
        hintText: hintext,
        hintStyle: TextStyle(color: Colors.black.withAlpha(100)),
      ),
    );
  }
}

