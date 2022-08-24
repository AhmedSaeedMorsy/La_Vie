import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/data/network/remote/dio.dart';
import 'package:la_vie/domain/product_model.dart';
import 'package:la_vie/presentation/shop/view_model/states.dart';
import 'package:sqflite/sqflite.dart';
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
      } else {
        print(error.toString());
        emit(ProductPageErrorState(error.toString()));
      }
    });
  }

  void incressCounter() {
    emit(IncressCounterState());
  }

  void decressCounter() {
    emit(DecressCounterState());
  }

//SqlLite

  late Database database;

  void createDataBase() {
    openDatabase(
      "carts.db",
      version: 1,
      onCreate: (database, version) {
        print("database is created");
        database.execute(
            "create table carts (id integer primary key , imgUrl text , name text , price integer , counter integer)");
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print("database is opened");
      },
    ).then((value) {
      database = value;
      emit(OpenDataBaseState());
    });
  }

  insertDataBase({
    required String name,
    required int price,
    required String imgUrl,
    required int counter,
  }) async {
    await database.transaction((txn) async {
      return txn
          .rawInsert(
              "insert into carts (name , imgUrl , price , counter) VALUES('$name','$imgUrl', '$price' , '$counter') ")
          .then((value) {
        print("$value is inserted");
        getDataFromDataBase(database);
        emit(AddToCartState());
      });
    });
  }

  List<Map> carts = [];
  void getDataFromDataBase(database) {
    carts = [];
    database.rawQuery("select * from carts").then((value) {
      value.forEach((element) {
        carts.add(element);
      });
      emit(GetFromMyCartState());
    });
  }

  void deleteFromDataBase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM carts WHERE id = ?', [id]).then((value) {
      emit(DeleteFromMyCartState());
      getDataFromDataBase(database);
    });
  }
}
