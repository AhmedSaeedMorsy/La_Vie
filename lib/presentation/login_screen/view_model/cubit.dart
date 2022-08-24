import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/data/network/remote/dio.dart';
import 'package:la_vie/domain/user_model.dart';
import 'package:la_vie/presentation/login_screen/view_model/states.dart';
import 'package:la_vie/presentation/resources/end_points.dart';
import 'package:la_vie/presentation/resources/google_signIn_helper.dart';

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
        } else if (error.response!.data["message"] is List) {
          print(error.response!.data["message"][0]);

          emit(RegisterErrorState(error.response!.data["message"][0]));
        }
      }
    });
  }

  GoogleSignInAccount? user;
  Future signInWithGoogle() async {
    user = await GoogleSignInApi.login();
    print(user!.id);
    DioHelper.postData(
      data: {
        "id": user!.id,
        "email": user!.email,
        "firstName": user!.displayName,
        "lastName": user!.displayName,
        "picture": user!.photoUrl
      },
      url: googleSignIn,
    ).then((value) {
      CacheHelper.setData(key: SharedKeys.token,value: user!.id);
      print(value.data);
      emit(SigninWithGoogleSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.data["message"] is String) {
          print(error.response!.data["message"]);

          emit(SigninWithGoogleErrorState(error.response!.data["message"]));
        } else if (error.response!.data["message"] is List) {
          print(error.response!.data["message"][0]);

          emit(SigninWithGoogleErrorState(error.response!.data["message"][0]));
        }
      }
    });
  }
}
