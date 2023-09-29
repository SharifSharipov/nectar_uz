import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nectar_uz/data/firebase/category_service.dart';
import 'package:nectar_uz/data/firebase/order_service.dart';
import 'package:nectar_uz/data/firebase/product_service.dart';
import 'package:nectar_uz/data/firebase/profile_service.dart';
import 'package:nectar_uz/provider/auth_provider.dart';
import 'package:nectar_uz/provider/category_provayder.dart';
import 'package:nectar_uz/provider/order_provider.dart';
import 'package:nectar_uz/provider/product_provayder.dart';
import 'package:nectar_uz/provider/profile_provider.dart';
import 'package:nectar_uz/ui/splash_screen_1/splash_screen_1.dart';
import 'package:provider/provider.dart';
import 'data/firebase/auth_service.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthProvider(firebaseServices: AutService()),
        lazy: true,
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(profileService: ProfileService()),
        lazy: true,
      ),
      ChangeNotifierProvider(
        create: (context) =>ProductsProvider(productsService:ProductServices()),
        lazy: true,
      ),
      ChangeNotifierProvider(
        create: (context) => CategoryProvider(categoryService: CategoryService()),
        lazy: true,
      ),
      ChangeNotifierProvider(
        create: (context) =>OrderProvider(orderService: OrderService()),
        lazy: true,
      ),
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          theme: ThemeData.dark(),
        );
      },
      child:SplashScreen_1(),
    );
  }
}
