import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/data/network/local/shared_pref.dart';
import 'package:la_vie/data/network/remote/dio.dart';
import 'package:la_vie/presentation/create_post_screen/view_model/states.dart';

import '../../resources/end_points.dart';

class CreatePostCubit extends Cubit<CreatePostStates> {
  CreatePostCubit() : super(CreatePostInitState());
  static CreatePostCubit get(context) => BlocProvider.of(context);

  File? _postImage;
  var picker = ImagePicker();
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _postImage = File(pickedFile.path);
      convertImage(_postImage!);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  String? img64;
  Future convertImage(File image) async {
    Uint8List? imageByets = await image.readAsBytes();
    img64 = base64.encode(imageByets);
    print(img64);
  }

  void uploadPost({
    required String title,
    required String description,
  }) {
    emit(CreatePostLoadingState());
    DioHelper.postData(
      url: createPostUrl,
      data: {
        "title": title,
        "description": description,
        "imageBase64": img64,
      },
      token: CacheHelper.getData(
        key: SharedKeys.token,
      ),
    ).then((value) {
      print(img64);
      print(value.data);
      print("شكرا ");
      emit(CreatePostSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data);
        print(img64);
        emit(CreatePosErrorState(error.response!.data["message"]));
      }
    });
  }
}
