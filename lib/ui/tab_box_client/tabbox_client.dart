import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar_uz/ui/tab_box_client/shop_screen_client/shop_screen.dart';
import '../../utils/app_colors.dart';
import '../../utils/appicons.dart';
import 'account_screen_client/account_screen_client.dart';
import 'cart_screen_client/cart_screen_client.dart';
import 'explore_Screen_client/expilore_screen.dart';
class TabboxScreens_client extends StatefulWidget {
  const TabboxScreens_client({super.key});

  @override
  State<TabboxScreens_client> createState() => _TabboxScreens_clientState();
}

class _TabboxScreens_clientState extends State<TabboxScreens_client> {
  int currentIndex = 0;
  final screens = [
    ShopScreen_client(),
    ExpiloreScreen_client(),
    CartScreen_client(),
    AccountScreen_client(),
  ];
  final items = [
    SvgPicture.asset(AppImages.shop,color: AppColors.c_030303,),
    SvgPicture.asset(AppImages.explore,color: AppColors.c_030303),
    SvgPicture.asset(AppImages.cart,color: AppColors.c_030303),
    SvgPicture.asset(AppImages.person,color: AppColors.c_030303),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: screens[currentIndex],
      bottomNavigationBar:CurvedNavigationBar(
        color: Colors.grey.shade200,
        backgroundColor: Colors.transparent,
        height: 60,
        items: items,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}

