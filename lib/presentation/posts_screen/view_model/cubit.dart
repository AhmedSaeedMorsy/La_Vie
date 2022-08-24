import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/data/network/remote/dio.dart';
import 'package:la_vie/presentation/posts_screen/view_model/states.dart';
import 'package:la_vie/presentation/resources/end_points.dart';

import '../../../domain/post_model.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitState());
  static PostsCubit get(context) => BlocProvider.of(context);
  PostModel postModel = PostModel();
  void getAllPosts() {
    emit(PostsLoadingState());
    DioHelper.getData(
      url: allPosts,
      token: CacheHelper.getData(key: SharedKeys.token),
    ).then((value) {
      postModel = PostModel.fromJson(value.data);
      print(postModel.message);
      emit(PostsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data["message"]);
        emit(PostsErrorState(error.response!.data["message"]));
      }
      print(error.toString());
      emit(PostsErrorState(error.toString()));
    });
  }

  PostModel myPostsList = PostModel();
  void getMyPosts() {
    emit(PostsLoadingState());
    DioHelper.getData(
      url: myPosts,
      token: CacheHelper.getData(key: SharedKeys.token),
    ).then((value) {
      myPostsList = PostModel.fromJson(value.data);
      print(postModel.message);
      emit(PostsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data["message"]);
        emit(PostsErrorState(error.response!.data["message"]));
      }
      print(error.toString());
      emit(PostsErrorState(error.toString()));
    });
  }
}
