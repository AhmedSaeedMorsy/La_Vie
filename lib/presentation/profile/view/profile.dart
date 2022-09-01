import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/presentation/profile/view_model/cubit.dart';
import 'package:la_vie/presentation/profile/view_model/states.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: AppSize.sInt1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetsManager.giftPlant),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: AppSize.s70,
                      backgroundImage: AssetImage(AssetsManager.icon),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.s8,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppPadding.p22,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.grey2,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppSize.s8,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.points,
                                ),
                                const SizedBox(
                                  width: AppSize.s12,
                                ),
                                Text(
                                  AppStrings.numPoints,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.grey2,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppSize.s8,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.iconChange,
                                ),
                                const SizedBox(
                                  width: AppSize.s12,
                                ),
                                Text(
                                  AppStrings.changeName,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  AssetsManager.arrow,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.grey2,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppSize.s8,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.iconChange,
                                ),
                                const SizedBox(
                                  width: AppSize.s12,
                                ),
                                Text(
                                  AppStrings.changeEmail,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  AssetsManager.arrow,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        InkWell(
                          onTap: () {
                            CacheHelper.removeData(key: SharedKeys.token);
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorManager.grey2,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppSize.s8,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AssetsManager.iconChange,
                                  ),
                                  const SizedBox(
                                    width: AppSize.s12,
                                  ),
                                  Text(
                                    "SignOut",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    AssetsManager.arrow,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
