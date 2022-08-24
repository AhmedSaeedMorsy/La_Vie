import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

import 'assets_manager.dart';
import 'strings_manager.dart';

class SharedWidget {
  static Widget defaultTextFormField(
          {required TextEditingController controller,
          required TextInputType textInputType,
          bool obscure = false,
          String? Function(String?)? validator,
          Function()? onTap,
          InputBorder? border,
          String? hint,
          int maxLines = 1,
          Color? fillColor}) =>
      TextFormField(
        cursorColor: ColorManager.lightGreen,
        onTap: onTap,
        obscureText: obscure,
        decoration: InputDecoration(
            border: border, hintText: hint, fillColor: fillColor),
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
      );
  static Widget noItemWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AssetsManager.empty),
        const SizedBox(
          height: AppSize.s30,
        ),
        Text(
          AppStrings.cartEmpty,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Text(
          AppStrings.emptyBio,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    );
  }
}
