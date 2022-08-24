abstract class PostsStates {}

class PostsInitState extends PostsStates {}

class PostsLoadingState extends PostsStates {}

class PostsSuccessState extends PostsStates {}

class PostsErrorState extends PostsStates {
  final String error;
  PostsErrorState(this.error);
}
