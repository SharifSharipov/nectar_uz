import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nectar_uz/provider/profile_provider.dart';
import 'package:nectar_uz/ui/tab_box_client/account_screen_client/widget/account_widget.dart';
import 'package:nectar_uz/utils/app_colors.dart';
import 'package:nectar_uz/utils/appicons.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class AccountScreen_client extends StatefulWidget {
  const AccountScreen_client({super.key});

  @override
  State<AccountScreen_client> createState() => _AccountScreen_clientState();
}

class _AccountScreen_clientState extends State<AccountScreen_client> {
  @override
  Widget build(BuildContext context) {
    User? user = context.read<ProfileProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Account screen",
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Gilroy',
              color: AppColors.c_030303),
        ),
        centerTitle: true,
        backgroundColor: AppColors.c_ffffff,
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthProvider>().logOut(context);
              },
              icon: const Icon(Icons.logout,color: AppColors.c_030303,))
        ],
      ),
      backgroundColor: AppColors.c_ffffff,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child:Row(
              children: [
                Container(
                  height: 66,
                  width: 66,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      color: Colors.grey
                  ),
                  child: user!.photoURL ==null
                      ? Icon(Icons.person,color: Colors.black,)
                      : Image.network(
                    user!.photoURL!,
                    width: 70,
                    height: 70,
                  ),
                ),
                const SizedBox(width: 30,),
                Expanded(  // Added Expanded widget to avoid rendering issues
                  child: Column(
                    children: [
                      Text(
                        user?.displayName ?? "",
                        style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy',
                            color: AppColors.c_030303),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        user?.email ?? "",
                        style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy',
                            color: AppColors.c_030303),
                      ),
                    ],
                  ),
                )
              ],
            )

          ),
          const Divider(color: AppColors.c_030303,),
          const Account_listile(text: 'Orders', iconca: AppImages.box_),
          const Divider(color: AppColors.c_030303,),
          const Account_listile(text: 'My Details', iconca: AppImages.info),
          const Divider(color: AppColors.c_030303,),
          const Account_listile(text: 'Diliver Addres', iconca: AppImages.mestopolejeniya),
          const Divider(color: AppColors.c_030303,),
          const Account_listile(text: 'Paymet Methods', iconca: AppImages.cart_),
          const Divider(color: AppColors.c_030303,),
          const Account_listile(text: 'Promo Cord', iconca: AppImages.promocod),
          const Divider(color: AppColors.c_030303,),
          const Account_listile(text: 'Notifications', iconca: AppImages.notification),
          const Divider(color: AppColors.c_030303,),
          const Account_listile(text: 'Help', iconca: AppImages.help),
          const Divider(color: AppColors.c_030303,),
          const Account_listile(text: 'About', iconca: AppImages.about),
          const Divider(color: AppColors.c_030303,),

        ],
      ),
    );
  }
}
