abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String userId;

  SocialLoginSuccessState(this.userId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialLoginPasswordState extends SocialLoginStates {}
