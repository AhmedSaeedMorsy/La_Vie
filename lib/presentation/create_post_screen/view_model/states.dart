abstract class CreatePostStates {}

class CreatePostInitState extends CreatePostStates {}

class CreatePostLoadingState extends CreatePostStates {}

class CreatePostSuccessState extends CreatePostStates {}

class CreatePosErrorState extends CreatePostStates {
  final String error;

  CreatePosErrorState(this.error);
}

class PostImagePickedSuccessState extends CreatePostStates {}

class PostImagePickedErrorState extends CreatePostStates {}
