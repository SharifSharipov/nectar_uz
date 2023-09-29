import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../utils/constants.dart';
import '../auth_screen/siginup_screen/sign_up.dart';
import '../tab_box_admin/tabbox_admin.dart';
import '../tab_box_client/tabbox_client.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthProvider>().listenAutenststate(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString(),));
        }else if(snapshot.data==null){
          return SignUpScreen();
        }
        else{
          return snapshot.data!.email ==adminEmail
              ? TabboxScreens_admin()
              : TabboxScreens_client();
        }
        },
      ),
    );
  }
}
