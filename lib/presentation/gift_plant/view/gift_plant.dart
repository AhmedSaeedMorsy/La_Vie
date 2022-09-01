import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/common/widget.dart';

import '../../resources/color_manager.dart';

class GiftPlantScreen extends StatelessWidget {
  GiftPlantScreen({Key? key}) : super(key: key);
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: AppSize.s300,
                decoration:const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.giftPlant),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(
                        AssetsManager.icon,
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Text(
                      AppStrings.giftPlantTitle,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: FontSizeManager.s24,
                          ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    SharedWidget.defaultTextFormField(
                        hint: AppStrings.address,
                        controller: addressController,
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.s8,
                        ),
                        color: ColorManager.lightGreen,
                      ),
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.send,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.s8,
                        ),
                        border: Border.all(color: ColorManager.grey2),
                        color: ColorManager.primary,
                      ),
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.mobileLayoutRoute);
                        },
                        child: Text(
                          AppStrings.saveForLater,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
