import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/edit_profile_screen.dart';
import 'package:social_app/shared/components/defaults.dart';
import 'package:social_app/shared/cubit/social_cubit/cubit.dart';
import 'package:social_app/shared/cubit/social_cubit/states.dart';
import 'package:social_app/shared/styles/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialUserModel model = SocialAppCubit.get(context).userModel;
        return ConditionalBuilder(
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
                        child: Image(
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            image: NetworkImage("${model.cover}")),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 51,
                          backgroundColor: appColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("${model.image}"),
                            radius: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${model.name}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "${model.phone}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "${model.bio}",
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text("Following"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "10K",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text("Followers"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "200",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text("Posts"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "50",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text("Photos"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text("Add Photo"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context: context, page: EditProfileScreen());
                      },
                      child: Icon(IconBroken.Edit),
                    ),
                  ],
                ),
                defaultButton(
                    text: "Signout",
                    function: () {
                      SocialAppCubit.get(context).signOut(context);
                    })
              ],
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
