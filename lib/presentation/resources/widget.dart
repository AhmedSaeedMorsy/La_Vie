import 'package:flutter/material.dart';

class SharedWidget {
  static Widget defaultTextFormField(
          {required TextEditingController controller,
          required TextInputType textInputType,
          bool obscure = false,
          String? Function(String?)? validator,
          Function()? onTap,
          InputBorder? border,
          String? hint,
          Color? fillColor}) =>
      TextFormField(
        onTap: onTap,
        obscureText: obscure,
        decoration: InputDecoration(
            border: border, hintText: hint, fillColor: fillColor),
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
      );
}
