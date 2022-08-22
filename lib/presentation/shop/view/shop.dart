import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/constants_manager.dart';
import 'package:la_vie/presentation/resources/routes_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/resources/widget.dart';
import 'package:la_vie/presentation/shop/view_model/cubit.dart';
import 'package:la_vie/presentation/shop/view_model/states.dart';

import '../../../domain/product_model.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<ShopScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController =
        TabController(length: AppConstants.lenghthOfPlantsTap, vsync: this);
    return BlocConsumer<ProductPageCubit, ProductPageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Container(
                child: Column(
                  children: [
                    const Center(
                      child: Image(
                        image: AssetImage(
                          AssetsManager.icon,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: AppConstants.int6,
                          child: InkWell(
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
                        ),
                        const SizedBox(
                          width: AppSize.s16,
                        ),
                        Expanded(
                          flex: AppConstants.int1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              color: ColorManager.lightGreen,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.myCartRoute,
                                );
                              },
                              child: SvgPicture.asset(
                                AssetsManager.basket,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                      child: TabBar(
                        labelPadding:
                            const EdgeInsets.symmetric(vertical: AppSize.s4),
                        controller: tabController,
                        labelColor: ColorManager.lightGreen,
                        labelStyle: Theme.of(context).textTheme.displayLarge,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSize.s8,
                          ),
                          border: Border.all(
                              color: ColorManager.lightGreen,
                              width: AppSize.s2),
                        ),
                        unselectedLabelColor: ColorManager.grey1,
                        tabs: [
                          Text(
                            AppStrings.all,
                          ),
                          Text(
                            AppStrings.plants,
                          ),
                          Text(
                            AppStrings.seeds,
                          ),
                          Text(
                            AppStrings.tools,
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
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          //All Products
                          gridView(
                            List.generate(
                              ProductPageCubit.get(context)
                                  .productModel
                                  .data
                                  .length,
                              (index) => buildGradItem(
                                ProductPageCubit.get(context)
                                    .productModel
                                    .data[index],
                                ProductPageCubit.get(context).counter,
                              ),
                            ),
                          ),

                          //Plant Products
                          gridView(
                            List.generate(
                              ProductPageCubit.get(context).plants.length,
                              (index) => buildGradItem(
                                ProductPageCubit.get(context).plants[index],
                                ProductPageCubit.get(context).counter,
                              ),
                            ),
                          ),

                          //Seeds Products
                          gridView(
                            List.generate(
                              ProductPageCubit.get(context).seeds.length,
                              (index) => buildGradItem(
                                ProductPageCubit.get(context).seeds[index],
                                ProductPageCubit.get(context).counter,
                              ),
                            ),
                          ),

                          //Tools Products
                          gridView(
                            List.generate(
                              ProductPageCubit.get(context).tools.length,
                              (index) => buildGradItem(
                                ProductPageCubit.get(context).tools[index],
                                ProductPageCubit.get(context).counter,
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
          ),
        );
      },
    );
  }

  Widget gridView(
    List<Widget> widget,
  ) {
    return ConditionalBuilderRec(
      condition: widget.isNotEmpty,
      builder: (context) => GridView.count(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: AppSize.sInt2,
        mainAxisSpacing: AppSize.s12,
        crossAxisSpacing: AppSize.s2,
        childAspectRatio: AppSize.s1 / AppSize.s1_4,
        children: widget,
      ),
      fallback: (context) => Center(
        child: CircularProgressIndicator(color: ColorManager.lightGreen),
      ),
    );
  }

  Widget buildGradItem(
    ProductData model,
    int counter,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
      child: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: AppSize.s200,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(AppSize.s_2),
                    spreadRadius: AppSize.s2,
                    blurRadius: AppSize.s5,
                    offset: const Offset(AppSize.s0, AppSize.s4),
                  ),
                ],
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.s8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      model.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      "${model.price} ${AppStrings.egb}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Container(
                      height: AppSize.s40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSize.s8,
                        ),
                        color: ColorManager.lightGreen,
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.addToCart,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: AppSize.s80,
                    image: NetworkImage(baseUrl + model.imageUrl),
                  ),
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              ProductPageCubit.get(context).decressCounter();
                            },
                            child: Text(AppStrings.mins)),
                        const SizedBox(
                          width: AppSize.s5,
                        ),
                        Text("$counter"),
                        const SizedBox(
                          width: AppSize.s5,
                        ),
                        InkWell(
                          onTap: () {
                            ProductPageCubit.get(context).incressCounter();
                          },
                          child: Text(
                            AppStrings.plus,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
