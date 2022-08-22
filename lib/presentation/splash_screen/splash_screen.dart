

import 'package:flutter/material.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/presentation/web_layout/web_layout.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../login_screen/view/login_screen.dart';
import '../mobile_layout/view/mobile_layout.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: nextScreen(),
      duration: AppConstants.splashTime,
      imageSrc: AssetsManager.icon,
      backgroundColor: ColorManager.primary,
    );
  }
  
Widget nextScreen (){
  if(CacheHelper.getData(key: SharedKeys.token)!= null){
    return const MobileLayoutScreen();
  }
  return const LoginScreen();
}

}
