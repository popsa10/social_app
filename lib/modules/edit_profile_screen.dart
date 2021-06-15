import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/defaults.dart';
import 'package:social_app/shared/cubit/social_cubit/cubit.dart';
import 'package:social_app/shared/cubit/social_cubit/states.dart';
import 'package:social_app/shared/styles/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is SocialGetUserDataSuccessState) {
          nameController.text = state.model.name;
          bioController.text = state.model.bio;
          phoneController.text = state.model.phone;
        }
      },
      builder: (context, state) {
        SocialUserModel model = SocialAppCubit.get(context).userModel;
        var profileImage = SocialAppCubit.get(context).profileImage;
        var coverImage = SocialAppCubit.get(context).coverImage;
        nameController.text = model.name;
        bioController.text = model.bio;
        phoneController.text = model.phone;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: defaultAppbar(
                context: context,
                title: "Edit Profile",
                actions: [
                  defaultTextButton(
                      function: () {
                        SocialAppCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                        );
                      },
                      text: "update"),
                  SizedBox(
                    width: 10,
                  )
                ]),
            body: ConditionalBuilder(
              condition: state is! SocialGetUserDataLoadingState,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 180,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Image(
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    image: (coverImage == null)
                                        ? NetworkImage("${model.cover}")
                                        : FileImage(coverImage)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 17,
                                    child: IconButton(
                                      icon: Icon(
                                        IconBroken.Camera,
                                        size: 17,
                                      ),
                                      onPressed: () {
                                        SocialAppCubit.get(context)
                                            .getCoverImage();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 51,
                                  backgroundColor: appColor,
                                  child: CircleAvatar(
                                    backgroundImage: profileImage == null
                                        ? NetworkImage("${model.image}")
                                        : FileImage(profileImage),
                                    radius: 50,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 17,
                                  child: IconButton(
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 17,
                                    ),
                                    onPressed: () {
                                      SocialAppCubit.get(context)
                                          .getProfileImage();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (SocialAppCubit.get(context).profileImage != null ||
                        SocialAppCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialAppCubit.get(context).profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: () {
                                      SocialAppCubit.get(context)
                                          .uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    text: 'upload profile',
                                  ),
                                  if (state is SocialUpdateUserDataLoadingState)
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  if (state is SocialUpdateUserDataLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (SocialAppCubit.get(context).coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: () {
                                      SocialAppCubit.get(context)
                                          .uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    text: 'upload cover',
                                  ),
                                  if (state is SocialUpdateUserDataLoadingState)
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  if (state is SocialUpdateUserDataLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (SocialAppCubit.get(context).profileImage != null ||
                        SocialAppCubit.get(context).coverImage != null)
                      SizedBox(
                        height: 20.0,
                      ),
                    defaultFormField(
                        controller: nameController,
                        label: "Name",
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Name Must Not Be Empty";
                          }
                        },
                        prefix: IconBroken.User,
                        type: TextInputType.name),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        controller: bioController,
                        label: "Bio",
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Bio Must Not Be Empty";
                          }
                        },
                        prefix: IconBroken.Info_Circle,
                        type: TextInputType.text),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        label: "Phone",
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Phone Must Not Be Empty";
                          }
                        },
                        prefix: IconBroken.Call,
                        type: TextInputType.phone),
                  ],
                ),
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}
