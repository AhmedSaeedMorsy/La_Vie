import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/data/network/remote/dio.dart';
import 'package:la_vie/domain/product_model.dart';
import 'package:la_vie/presentation/shop/view_model/states.dart';

import '../../resources/end_points.dart';

class ProductPageCubit extends Cubit<ProductPageStates> {
  ProductPageCubit() : super(ProductPageInitState());
  static ProductPageCubit get(context) => BlocProvider.of(context);
  ProductModel productModel = ProductModel();
  List plants = [];
  List seeds = [];
  List tools = [];
  void getProduct() {
    emit(ProductPageLoadingState());
    DioHelper.getData(
            url: products, token: CacheHelper.getData(key: SharedKeys.token))
        .then((value) {
      productModel = ProductModel.fromJson(value.data);
      for (var element in productModel.data) {
        if (element.type == "PLANT") {
          plants.add(element);
        }
        if (element.type == "SEED") {
          seeds.add(element);
        }
        if (element.type == "TOOL") {
          tools.add(element);
        }
      }
      print(productModel.message);

      emit(ProductPageSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data["message"]);

        emit(ProductPageErrorState(error.response!.data["message"]));
      }
    });
  }

  int counter = 1;
  void incressCounter() {
    counter++;
    emit(IncressCounterState());
  }
   void decressCounter() {
    counter--;
    emit(DecressCounterState());

  }
}
