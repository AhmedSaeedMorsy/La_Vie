import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/presentation/mobile_layout/view_model/cubit.dart';
import 'package:la_vie/presentation/mobile_layout/view_model/states.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/constants_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

import '../../resources/assets_manager.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileCubit(),
      child: BlocConsumer<MobileCubit, MobileLayOutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: Container(
              height: AppSize.s70,
              color: ColorManager.primaryWithOpacity,
              child: Stack(
                children: [
                  Center(
                    heightFactor: AppSize.s_2,
                    child: CircleAvatar(
                      backgroundColor: ColorManager.primary,
                      radius: AppSize.s50,
                      child: FloatingActionButton(
                        backgroundColor: ColorManager.lightGreen,
                        onPressed: () {
                          MobileCubit.get(context).changeIndex(AppSize.sInt0);
                        },
                        child: SvgPicture.asset(
                          AssetsManager.home,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            MobileCubit.get(context).changeIndex(AppSize.sInt1);
                          },
                          icon: SvgPicture.asset(
                            AssetsManager.leaf,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            MobileCubit.get(context).changeIndex(AppSize.sInt2);
                          },
                          icon: SvgPicture.asset(
                            AssetsManager.qrCode,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        IconButton(
                          onPressed: () {
                            MobileCubit.get(context).changeIndex(AppSize.sInt3);
                          },
                          icon: SvgPicture.asset(
                            AssetsManager.notification,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            MobileCubit.get(context).changeIndex(AppSize.sInt4);
                          },
                          icon: SvgPicture.asset(
                            AssetsManager.personIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: MobileCubit.get(context)
                .bottomNavItem[MobileCubit.get(context).currentIndex],
          );
        },
      ),
    );
  }
}
