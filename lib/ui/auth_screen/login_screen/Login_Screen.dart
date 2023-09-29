import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar_uz/ui/auth_screen/siginup_screen/sign_up.dart';
import 'package:nectar_uz/ui/auth_screen/widget/text_field_password.dart';

import 'package:nectar_uz/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../utils/appicons.dart';
import '../widget/global_button.dart';
import '../widget/global_text_field_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_ffffff,
      body: ListView(
       children: [
         Container(
           margin: EdgeInsets.only(left: 24,right: 24),
           child: Column(
             children: <Widget>[
               SizedBox(height: 70,),
               Center(
                 child: SvgPicture.asset(AppImages.carrot),
               ),
               const Align(
                 alignment: Alignment.centerLeft,
                 child: Text(
                   'Loging',
                   style: TextStyle(
                       fontStyle: FontStyle.normal,
                       fontSize: 26,
                       fontWeight: FontWeight.w600,
                       fontFamily: 'Gilroy',
                       color: AppColors.c_030303),
                 ),
               ),
               const Align(
                 alignment: Alignment.centerLeft,
                 child: Text(
                   'Enter your emails and password',
                   style: TextStyle(
                       fontStyle: FontStyle.normal,
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       fontFamily: 'Gilroy',
                       color: AppColors.c_7C7C7C),
                 ),
               ),
               const  SizedBox(height: 30,),
               const Align(
                 alignment: Alignment.centerLeft,
                 child: Text(
                   'Email',
                   style: TextStyle(
                       fontStyle: FontStyle.normal,
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       fontFamily: 'Gilroy',
                       color: AppColors.c_7C7C7C),
                 ),
               ),
               GloballineTextField(
                 hintext: 'example@gmail.com',
                 controller: context.read<AuthProvider>().emailControler,
               ),
               const  SizedBox(height: 30,),
               const Align(
                 alignment: Alignment.centerLeft,
                 child: Text(
                   'Password',
                   style: TextStyle(
                       fontStyle: FontStyle.normal,
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                       fontFamily: 'Gilroy',
                       color: AppColors.c_7C7C7C),
                 ),
               ),
               GloballineTextFieldpassword(
                 hintext: 'qwerty123',
                 controller:
                 context.read<AuthProvider>().passwordControler,
               ),
               const SizedBox(
                 height: 25,
               ),
               const Align(
                 alignment: Alignment.centerRight,
                 child: Text(
                   'Forgot password?',
                   style: TextStyle(
                       fontStyle: FontStyle.normal,
                       fontSize: 16,
                       fontWeight: FontWeight.w500,
                       fontFamily: 'Gilroy',
                       color:  AppColors.c_181725),
                 ),
               ),
               const SizedBox(
                 height: 5,
               ),
               GlobalButton(title: "Log In", onTap: (){
                 context.read<AuthProvider>().login(context);
               }, color:AppColors.c_53B175,),
               const SizedBox(height: 25,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text(
                     'Don\'t have an account ?',
                     style: TextStyle(
                         fontStyle: FontStyle.normal,
                         fontSize: 14,
                         fontWeight: FontWeight.w600,
                         fontFamily: 'Gilroy',
                         color: AppColors.c_181725),
                   ),
                   TextButton(
                       onPressed: () {
                         Navigator.pushReplacement(context,
                             MaterialPageRoute(builder: (context) {
                               return SignUpScreen();
                             }));
                       },
                       child: const Row(
                         children: [
                           Text(
                             'Sign Up',
                             style: TextStyle(
                                 fontStyle: FontStyle.normal,
                                 fontSize: 14,
                                 fontWeight: FontWeight.w600,
                                 fontFamily: 'Gilroy',
                                 color: AppColors.c_53B175),
                           )
                         ],
                       )),
                 ],
               )
             ],
           ),
         ),
       ],
      ),
    );
  }
}