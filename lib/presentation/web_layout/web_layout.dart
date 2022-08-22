import 'package:flutter/material.dart';
import 'package:la_vie/presentation/login_screen/view/login_screen.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class WebLayoutScreen extends StatelessWidget {
  const WebLayoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppConstants.lengthOfTap,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: AppSize.s80,
          leadingWidth: AppSize.s150,
          leading: const Padding(
            padding: EdgeInsets.only(
              left: AppPadding.p40,
              right: AppPadding.p40,
            ),
            child: Image(
              image: AssetImage(
                AssetsManager.icon,
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          title: TabBar(
            labelColor: ColorManager.lightGreen,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            indicatorColor: ColorManager.primary,
            unselectedLabelColor: ColorManager.black,
            tabs: [
              tap(context, AppStrings.home),
              tap(context, AppStrings.shop),
              tap(context, AppStrings.blog),
              tap(context, AppStrings.about),
              tap(context, AppStrings.community),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(AppPadding.p22),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.lightGreen,
                  textStyle: getMediumStyle(
                    color: ColorManager.primary,
                    fontSize: FontSizeManager.s20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSize.s8,
                    ),
                  ),
                ),
                onPressed: () {
                  ///////////////////////////////////
                },
                child: Text(
                  AppStrings.signUp,
                ),
              ),
            ),
            const SizedBox(
              width: AppSize.s50,
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppPadding.p40,
            horizontal: AppPadding.p80,
          ),
          child: TabBarView(
            children: [
              LoginScreen(),
              LoginScreen(),
              LoginScreen(),
              LoginScreen(),
              LoginScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Tab tap(context, String label) {
    return Tab(
      text: label,
    );
  }
}
