import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:la_vie/presentation/create_post_screen/view_model/cubit.dart';
import 'package:la_vie/presentation/create_post_screen/view_model/states.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/common/widget.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostCubit(),
      child: BlocBuilder<CreatePostCubit, CreatePostStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.createPost,
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          CreatePostCubit.get(context).getPostImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppSize.s8,
                              ),
                              border: Border.all(
                                color: ColorManager.lightGreen,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p22,
                              horizontal: AppPadding.p16,
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.plus,
                                  color: ColorManager.lightGreen,
                                ),
                                SizedBox(
                                  height: AppSize.s20,
                                ),
                                Text(
                                  AppStrings.addPhoto,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.title,
                          ),
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          SharedWidget.defaultTextFormField(
                            controller: _titleController,
                            textInputType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.description,
                          ),
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          SharedWidget.defaultTextFormField(
                            controller: _descriptionController,
                            textInputType: TextInputType.text,
                            maxLines: AppSize.sInt8,
                          ),
                        ],
                      ),
                    ),
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
                        onPressed: () {
                          CreatePostCubit.get(context).uploadPost(
                            title: _titleController.text,
                            description: _descriptionController.text,
                          );
                        },
                        child: Text(
                          AppStrings.post,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
