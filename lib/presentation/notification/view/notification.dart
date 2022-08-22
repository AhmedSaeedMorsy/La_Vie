import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/constants_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p22),
        child: Container(
            child: Column(
          children: [
            Center(
              child: Text(
                AppStrings.notification,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return notificationItem(context);
                  },
                  separatorBuilder: (context, index) => Container(
                        height: AppSize.s1,
                        color: ColorManager.grey1,
                      ),
                  itemCount: AppConstants.int6),
            )
          ],
        )),
      ),
    );
  }

  Widget notificationItem(context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(AssetsManager.person),
            radius: AppSize.s30,
          ),
          const SizedBox(
            width: AppSize.s20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.notificationTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                Text(AppStrings.notificationTime)
              ],
            ),
          )
        ],
      ),
    );
  }
}
