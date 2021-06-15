abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {
  final String userId;

  SocialRegisterSuccessState(this.userId);
}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterPasswordState extends SocialRegisterStates {}

class SocialRegisterSaveDataSuccessState extends SocialRegisterStates {}

class SocialRegisterSaveDataErrorState extends SocialRegisterStates {}
