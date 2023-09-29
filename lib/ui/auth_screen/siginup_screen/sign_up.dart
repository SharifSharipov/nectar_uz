import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar_uz/ui/auth_screen/login_screen/Login_Screen.dart';
import 'package:nectar_uz/ui/auth_screen/widget/text_field_password.dart';
import 'package:nectar_uz/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth_provider.dart';
import '../../../utils/appicons.dart';
import '../widget/global_button.dart';
import '../widget/global_text_field_row.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_ffffff,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: SvgPicture.asset(AppImages.carrot),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sigin Up',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy',
                        color: Colors.black),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your Credentials to continue',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy',
                        color: AppColors.c_7C7C7C),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy',
                        color: AppColors.c_7C7C7C),
                  ),
                ),
                GloballineTextField(
                  hintext: 'Jokhn',
                  controller: context.read<AuthProvider>().userControler,
                ),
                const SizedBox(
                  height: 30,
                ),
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
                const SizedBox(
                  height: 30,
                ),
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
                  controller: context.read<AuthProvider>().passwordControler
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 366,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: AppColors.c_53B175),
                  child: TextButton(
                      onPressed: () {
                        context.read<AuthProvider>().signInWithGoogle(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(AppImages.google),
                          const Text(
                            "Continue with google ",
                            style: TextStyle(
                              color: AppColors.c_ffffff,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Gilroy',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                GlobalButton(
                    title: "Sign up",
                    onTap: ()async {
                      await context.read<AuthProvider>().signUp(context);

                    },
                    color: AppColors.c_3669C9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account ?',
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
                            return LoginScreen();
                          }));
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Logining',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
