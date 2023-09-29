import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
class FavoriteScreen_client extends StatefulWidget {
  const FavoriteScreen_client({super.key});

  @override
  State<FavoriteScreen_client> createState() => _FavoriteScreen_clientState();
}

class _FavoriteScreen_clientState extends State<FavoriteScreen_client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite screen",style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Gilroy',
            color: AppColors.c_030303),),
        centerTitle: true,
        backgroundColor: AppColors.c_ffffff,
      ),
      backgroundColor: AppColors.c_ffffff,
    );
  }
}

