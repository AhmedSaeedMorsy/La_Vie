import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/resources/widget.dart';
import 'package:la_vie/presentation/shop/view_model/cubit.dart';
import 'package:la_vie/presentation/shop/view_model/states.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductPageCubit, ProductPageStates>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.myCart,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p22),
          child: Center(
            child: ConditionalBuilderRec(
              condition: ProductPageCubit.get(context).carts.isNotEmpty,
              builder: (context) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => cartItem(
                      context, ProductPageCubit.get(context).carts[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: AppSize.s20,
                  ),
                  itemCount: ProductPageCubit.get(context).carts.length,
                );
              },
              fallback: (context) {
                return SharedWidget.noItemWidget(context);
              },
            ),
          ),
        ),
      );
    });
  }

  Widget cartItem(context, Map myCart) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(AppSize.s_2),
            spreadRadius: AppSize.s2,
            blurRadius: AppSize.s5,
            offset: const Offset(AppSize.s0, AppSize.s4),
          ),
        ],
        borderRadius: BorderRadius.circular(
          AppSize.s8,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSize.s12),
        child: Row(
          children: [
            Expanded(
              flex: AppSize.sInt1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppSize.s8,
                  ),
                ),
                child: Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    myCart['imgUrl'],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${myCart['name']}",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Text(
                      "${myCart['price']}",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p12),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                ProductPageCubit.get(context).decressCounter();
                              },
                              child: Text(
                                AppStrings.mins,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              )),
                          const SizedBox(
                            width: AppSize.s5,
                          ),
                          Text("${myCart['counter']}"),
                          const SizedBox(
                            width: AppSize.s5,
                          ),
                          InkWell(
                            onTap: () {
                              ProductPageCubit.get(context).incressCounter();
                            },
                            child: Text(
                              AppStrings.plus,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                ProductPageCubit.get(context)
                                    .deleteFromDataBase(id: myCart['id']);
                              },
                              child: SvgPicture.asset(AssetsManager.deleteIcon))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
