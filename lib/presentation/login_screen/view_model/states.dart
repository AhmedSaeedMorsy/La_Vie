abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String error;
  RegisterErrorState(this.error);
}

class SigninWithGoogleSuccessState extends AuthStates {}

class SigninWithGoogleErrorState extends AuthStates {
  final String error;

  SigninWithGoogleErrorState(this.error);
}
