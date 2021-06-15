import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';

abstract class SocialAppStates {}

class SocialInitialState extends SocialAppStates {}

class SocialGetUserDataLoadingState extends SocialAppStates {}

class SocialGetUserDataSuccessState extends SocialAppStates {
  final SocialUserModel model;

  SocialGetUserDataSuccessState(this.model);
}

class SocialGetUserDataErrorState extends SocialAppStates {}

class SocialGetAllUsersLoadingState extends SocialAppStates {}

class SocialGetAllUsersSuccessState extends SocialAppStates {}

class SocialGetAllUsersErrorState extends SocialAppStates {}

class SocialGetPostsLoadingState extends SocialAppStates {}

class SocialGetPostsSuccessState extends SocialAppStates {}

class SocialLikePostSuccessState extends SocialAppStates {}

class SocialLikePostErrorState extends SocialAppStates {}

class SocialGetPostsErrorState extends SocialAppStates {}

class SocialChangeBottomNavState extends SocialAppStates {}

class SocialNewPostState extends SocialAppStates {}

class SocialGetProfileImageSuccessState extends SocialAppStates {}

class SocialGetProfileImageErrorState extends SocialAppStates {}

class SocialGetCoverImageSuccessState extends SocialAppStates {}

class SocialGetCoverImageErrorState extends SocialAppStates {}

class SocialUploadProfileImageSuccessState extends SocialAppStates {}

class SocialUploadProfileImageErrorState extends SocialAppStates {}

class SocialUploadCoverImageSuccessState extends SocialAppStates {}

class SocialUploadCoverImageErrorState extends SocialAppStates {}

class SocialUpdateUserDataErrorState extends SocialAppStates {}

class SocialUpdateUserDataLoadingState extends SocialAppStates {}

class SocialUpdateUserDataSuccessState extends SocialAppStates {}

class SocialCreatePostLoadingState extends SocialAppStates {}

class SocialCreatePostSuccessState extends SocialAppStates {}

class SocialCreatePostErrorState extends SocialAppStates {}

class SocialPostImagePickedSuccessState extends SocialAppStates {}

class SocialPostImagePickedErrorState extends SocialAppStates {}

class SocialRemovePostImageState extends SocialAppStates {}

//chat
class SocialSendMessageSuccessState extends SocialAppStates {}

class SocialSendMessageErrorState extends SocialAppStates {}

class SocialGetMessageSuccessState extends SocialAppStates {}

class SocialGetMessageErrorState extends SocialAppStates {}
