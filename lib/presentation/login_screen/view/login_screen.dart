// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/presentation/login_screen/view_model/cubit.dart';
import 'package:la_vie/presentation/login_screen/view_model/states.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/constants_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/common/widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MobileLoginScreen();
  }
}

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController =
        TabController(length: AppConstants.lenghthOfLoginTap, vsync: this);
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  AssetsManager.tracedTop,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Image(
                      image: AssetImage(
                        AssetsManager.icon,
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      child: TabBar(
                        controller: tabController,
                        labelColor: ColorManager.lightGreen,
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        indicatorColor: ColorManager.primary,
                        unselectedLabelColor: ColorManager.grey1,
                        tabs: [
                          Text(
                            AppStrings.signUp,
                          ),
                          Text(
                            AppStrings.login,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: AppSize.s800,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [
                          RegisterScreenview(),
                          LoginScreenview(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(
                  AssetsManager.tracedBottom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreenview extends StatelessWidget {
  LoginScreenview({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          SharedWidget.toast(message: state.error);
        } else if (state is SigninWithGoogleErrorState) {
          SharedWidget.toast(message: state.error);
        } else if (state is LoginSuccessState ||
            state is SigninWithGoogleSuccessState) {
          CacheHelper.setData(
              key: SharedKeys.token,
              value: AuthCubit.get(context).userModel.data.accessToken);
          Navigator.pushNamed(context, Routes.mobileLayoutRoute);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.email,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSize.s10),
                SharedWidget.defaultTextFormField(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.emailValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text(
                  AppStrings.password,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSize.s10),
                SharedWidget.defaultTextFormField(
                  controller: passwordController,
                  obscure: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.passwordValidation;
                    } else if (value.length <
                        AppConstants.miniLengthOfPassword) {
                      return AppStrings.passwordValidationlength;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    AppStrings.forgetPassword,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                const SizedBox(height: AppSize.s50),
                ConditionalBuilderRec(
                  condition: state is LoginLoadingState,
                  builder: (context) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.lightGreen,
                      ),
                    );
                  },
                  fallback: (context) => Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: ColorManager.lightGreen,
                      borderRadius: BorderRadius.circular(
                        AppSize.s8,
                      ),
                    ),
                    child: MaterialButton(
                      height: AppSize.s50,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      child: Text(
                        AppStrings.login,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: AppSize.s1,
                        color: ColorManager.grey2,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p2),
                      child: Text(
                        AppStrings.loginString,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: AppSize.s1,
                        color: ColorManager.grey2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        AuthCubit.get(context).signInWithGoogle();
                      },
                      child: SvgPicture.asset(
                        AssetsManager.google,
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s30,
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        AssetsManager.facebook,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class RegisterScreenview extends StatelessWidget {
  RegisterScreenview({Key? key}) : super(key: key);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          SharedWidget.toast(
            message: state.error,
          );
        } else if (state is SigninWithGoogleErrorState) {
          SharedWidget.toast(message: state.error);
        } else if (state is RegisterSuccessState ||
            state is SigninWithGoogleSuccessState) {
          CacheHelper.setData(
              key: SharedKeys.token,
              value: AuthCubit.get(context).userModel.data.accessToken);
          Navigator.pushNamed(context, Routes.giftPlantRoute);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.firstName,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          SharedWidget.defaultTextFormField(
                            controller: firstNameController,
                            textInputType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppStrings.firstNameValidation;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.firstName,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: AppSize.s10,
                          ),
                          SharedWidget.defaultTextFormField(
                            controller: lastNameController,
                            textInputType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppStrings.lastNameValidation;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text(
                  AppStrings.email,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                SharedWidget.defaultTextFormField(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.emailValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text(
                  AppStrings.password,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSize.s10),
                SharedWidget.defaultTextFormField(
                  controller: passwordController,
                  obscure: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.passwordValidation;
                    } else if (value.length <
                        AppConstants.miniLengthOfPassword) {
                      return AppStrings.passwordValidationlength;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text(
                  AppStrings.confirmPassword,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: AppSize.s10),
                SharedWidget.defaultTextFormField(
                  controller: confirmPasswordController,
                  obscure: true,
                  textInputType: TextInputType.visiblePassword,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppStrings.confirmPasswordValidation;
                    } else if (confirmPasswordController.text !=
                        passwordController.text) {
                      return AppStrings
                          .confirmPasswordNotEqualPasswordValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s50),
                ConditionalBuilderRec(
                  condition: state is RegisterLoadingState,
                  builder: ((context) => Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.lightGreen,
                        ),
                      )),
                  fallback: (context) => Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: ColorManager.lightGreen,
                      borderRadius: BorderRadius.circular(
                        AppSize.s8,
                      ),
                    ),
                    child: MaterialButton(
                      height: AppSize.s50,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthCubit.get(context).userRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                          );
                        }
                      },
                      child: Text(
                        AppStrings.signUp,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: AppSize.s1,
                        color: ColorManager.grey2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p2,
                      ),
                      child: Text(
                        AppStrings.loginString,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: AppSize.s1,
                        color: ColorManager.grey2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        AuthCubit.get(context).signInWithGoogle();
                      },
                      child: SvgPicture.asset(
                        AssetsManager.google,
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s30,
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        AssetsManager.facebook,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
