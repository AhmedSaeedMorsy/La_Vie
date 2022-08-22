import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data/network/remote/dio.dart';
import 'package:la_vie/domain/user_model.dart';
import 'package:la_vie/presentation/login_screen/view_model/states.dart';
import 'package:la_vie/presentation/resources/end_points.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());
  static AuthCubit get(context) => BlocProvider.of(context);

  UserModel userModel = UserModel();
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: login, data: {
      'password': password,
      'email': email,
    }).then((value) {
      userModel = UserModel.fromjson(value.data);
      print(userModel.data.accessToken);
      emit(LoginSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data["message"]);

        emit(LoginErrorState(error.response!.data["message"]));
      }
    });
  }

  void userRegister({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: register, data: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    }).then((value) {
      userModel = UserModel.fromjson(value.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.data["message"] is String) {
          print(error.response!.data["message"]);

          emit(RegisterErrorState(error.response!.data["message"]));
        } else if(error.response!.data["message"] is List){
          print(error.response!.data["message"][0]);

          emit(RegisterErrorState(error.response!.data["message"][0]));
        }
      }
    });
  }
}
