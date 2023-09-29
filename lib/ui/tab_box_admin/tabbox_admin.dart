import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar_uz/ui/tab_box_admin/shop_screen_admin/shop_screen_admin.dart';
import '../../utils/app_colors.dart';
import '../../utils/appicons.dart';
import 'account_screen_admin/account_Screen_admin.dart';
import 'explore_Screen_admin/expilore_screen_admin.dart';
class TabboxScreens_admin extends StatefulWidget {
  const TabboxScreens_admin({super.key});
  @override
  State<TabboxScreens_admin> createState() => _TabboxScreens_adminState();
}
class _TabboxScreens_adminState extends State<TabboxScreens_admin> {
  int currentIndex = 0;
  final screens = [
    const ShopScreen_admin(),
    const ExpiloreScreen_admin(),
    const AccountScreen_admin(),
  ];
  final items = [
    SvgPicture.asset(AppImages.shop,color: AppColors.c_030303,),
    const Icon(Icons.category_outlined,color: AppColors.c_030303,),
    SvgPicture.asset(AppImages.person,color: AppColors.c_030303),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
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
