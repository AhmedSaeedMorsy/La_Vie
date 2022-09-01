import 'dart:async';

import 'package:flutter/material.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';

import '../login_screen/view/login_screen.dart';
import '../mobile_layout/view/mobile_layout.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  void _startDelay() {
    _timer =
        Timer(const Duration(seconds: AppConstants.splashTime), _nextScreen);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
          child: Image(
        image: AssetImage(AssetsManager.icon),
      )),
      backgroundColor: ColorManager.primary,
    );
  }

  void _nextScreen() {
    if (CacheHelper.getData(key: SharedKeys.token) != null) {
      Navigator.pushReplacementNamed(context, Routes.mobileLayoutRoute);
    }
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
