import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/presentation/posts_screen/view_model/cubit.dart';
import 'package:la_vie/presentation/posts_screen/view_model/states.dart';
import 'package:la_vie/presentation/resources/constants_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

import '../../../domain/post_model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with TickerProviderStateMixin {
      var floting1 ;
  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: AppSize.sInt2, vsync: this);
    return BlocProvider(
      create: (context) => PostsCubit()
        ..getAllPosts()
        ..getMyPosts(),
      child: BlocBuilder<PostsCubit, PostsStates>(builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      AppStrings.discussionForums,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.searchRoute,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.grey2),
                        borderRadius: BorderRadius.circular(
                          AppSize.s8,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsManager.search,
                            ),
                            const SizedBox(
                              width: AppSize.s16,
                            ),
                            Text(
                              AppStrings.search,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Container(
                    child: TabBar(
                      labelPadding:
                          const EdgeInsets.symmetric(vertical: AppSize.s4),
                      controller: _tabController,
                      labelColor: ColorManager.lightGreen,
                      labelStyle: Theme.of(context).textTheme.displayLarge,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.s8,
                        ),
                        border: Border.all(
                            color: ColorManager.lightGreen, width: AppSize.s2),
                      ),
                      unselectedLabelColor: ColorManager.grey1,
                      tabs: [
                        Text(
                          AppStrings.allForums,
                        ),
                        Text(
                          AppStrings.myForums,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Container(
                    height: AppSize.s373,
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ConditionalBuilderRec(
                          condition:
                              PostsCubit.get(context).postModel.data.isNotEmpty,
                          builder: (context) => ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => postItem(
                                  PostsCubit.get(context)
                                      .postModel
                                      .data[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: AppSize.s40,
                                  ),
                              itemCount: PostsCubit.get(context)
                                  .postModel
                                  .data
                                  .length),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.lightGreen,
                            ),
                          ),
                        ),
                        ConditionalBuilderRec(
                          condition:
                              PostsCubit.get(context).postModel.data.isNotEmpty,
                          builder: (context) => ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => postItem(
                                  PostsCubit.get(context)
                                      .myPostsList
                                      .data[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: AppSize.s40,
                                  ),
                              itemCount: PostsCubit.get(context)
                                  .myPostsList
                                  .data
                                  .length),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.lightGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: floting1,
              onPressed: () {
                Navigator.pushNamed(context, Routes.createPostRoute);
              },
              backgroundColor: ColorManager.lightGreen,
              child: SvgPicture.asset(AssetsManager.plus),
            ),
          ),
        );
      }),
    );
  }

  Widget postItem(
    PostData model,
  ) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: ColorManager.grey2,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(model.user.imageUrl),
                          radius: AppSize.s30,
                        ),
                        const SizedBox(
                          width: AppSize.s10,
                        ),
                        Expanded(
                          child: Text(
                            "${model.user.firstName} ${model.user.lastName}",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          model.title ?? "null",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Text(
                          model.description ?? "null",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Container(
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage("$baseUrl${model.imageUrl}"),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetsManager.likeIcon,
                    ),
                    const SizedBox(
                      width: AppSize.s5,
                    ),
                    Text("${model.forumLikes.length}"),
                    const SizedBox(
                      width: AppSize.s5,
                    ),
                    Text(
                      AppStrings.like,
                    ),
                  ],
                ),
                const SizedBox(
                  width: AppSize.s80,
                ),
                Row(
                  children: [
                    Text("${model.forumComments.length}"),
                    const SizedBox(
                      width: AppSize.s5,
                    ),
                    Text(
                      AppStrings.replay,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
