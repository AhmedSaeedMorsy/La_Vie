import 'package:flutter/material.dart';
import 'package:la_vie/presentation/create_post_screen/view/create_post_screen.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/search/view/search.dart';

import '../forget_password_screen/forget_password_screen.dart';
import '../gift_plant/view/gift_plant.dart';
import '../login_screen/view/login_screen.dart';
import '../mobile_layout/view/mobile_layout.dart';
import '../my_cart/view/my_cart.dart';
import '../posts_screen/view/posts_screen.dart';
import '../splash_screen/splash_screen.dart';
import '../web_layout/web_layout.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String postsRoute = "/posts";
  static const String webLayoutRoute = "/webLayOut";
  static const String mobileLayoutRoute = "/mobileLayOut";
  static const String searchRoute = "/search";
  static const String myCartRoute = "/myCart";
  static const String createPostRoute = "/createPost";
    static const String giftPlantRoute = "/giftPlant";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.webLayoutRoute:
        return MaterialPageRoute(
          builder: (_) => const WebLayoutScreen(),
        );
      case Routes.mobileLayoutRoute:
        return MaterialPageRoute(
          builder: (_) => const MobileLayoutScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
        );
      case Routes.postsRoute:
        return MaterialPageRoute(
          builder: (_) => const PostsScreen(),
        );
      case Routes.searchRoute:
        return MaterialPageRoute(
          builder: (_) => SearchScreen(),
        );
      case Routes.myCartRoute:
        return MaterialPageRoute(
          builder: (_) => const MyCartScreen(),
        );
      case Routes.createPostRoute:
        return MaterialPageRoute(
          builder: (_) => CreatePostScreen(),
        );
        case Routes.giftPlantRoute:
        return MaterialPageRoute(
          builder: (_) => GiftPlantScreen(),
        );
      default:
        return unDefiendRoute();
    }
  }

  static Route<dynamic> unDefiendRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.notFound),
        ),
        body: Center(
          child: Text(
            AppStrings.notFound,
          ),
        ),
      ),
    );
  }
}
