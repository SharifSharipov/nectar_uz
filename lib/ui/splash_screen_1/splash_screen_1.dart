import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar_uz/utils/app_colors.dart';
import 'package:nectar_uz/utils/appicons.dart';

import '../splash_screen/splash_screen.dart';

class SplashScreen_1 extends StatefulWidget {
  const SplashScreen_1({super.key});

  @override
  State<SplashScreen_1> createState() => _SplashScreen_1State();
}

class _SplashScreen_1State extends State<SplashScreen_1> {
  _init() async {
    await Future.delayed(const Duration(seconds: 3));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SplashScreen();

          },
        ),
      );
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.c_53B175,
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.carrot2),
                SizedBox(width: 20,),
                 Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                 SvgPicture.asset(AppImages.logo),
                   SizedBox(height: 10,),
                   SvgPicture.asset(AppImages.logo_2),
               ],),
            ],
          ),
        ),
      )
    );
  }
}