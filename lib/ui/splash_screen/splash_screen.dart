import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar_uz/ui/auth_screen/widget/global_button.dart';
import 'package:nectar_uz/utils/appicons.dart';
import '../../utils/app_colors.dart';
import '../app/app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /*_init() async {
    await Future.delayed(const Duration(seconds: 3));

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return App();
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
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              AppImages.onescreen,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppImages.carrot2),
                const Text(
                  "\t\t\tWelcome \n to our store",
                  style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: AppColors.c_ffffff,
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                      letterSpacing: 4),
                ),
                const Text("Ger your groceries in as fast as one hour",   style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: AppColors.c_ffffff,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    letterSpacing: 0.2),),
                const SizedBox(height: 60,),
                Padding(

                  padding: const EdgeInsets.all(30),
                  child: GlobalButton(title: "Get Started", onTap: (){
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return App();
                          },
                        ),
                      );
                    }
                  }, color: AppColors.c_53B175,),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
