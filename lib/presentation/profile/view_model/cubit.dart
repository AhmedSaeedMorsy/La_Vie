import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/data/network/remote/dio.dart';
import 'package:la_vie/presentation/profile/view_model/states.dart';

import '../../../domain/user_model.dart';
import '../../resources/end_points.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitState());
  static ProfileCubit get(context) => BlocProvider.of(context);
  UserModel userModel = UserModel();
  void getProfile() {
    DioHelper.getData(
            url: profileUrl, token: CacheHelper.getData(key: SharedKeys.token))
        .then((value) {
      userModel = UserModel.fromjson(value.data);
      print(userModel.data.accessToken);
      emit(ProfileSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data["message"]);

        emit(ProfileErrorState());
      }
    });
  }
}
