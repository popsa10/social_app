import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/defaults.dart';
import 'package:social_app/shared/cubit/social_cubit/cubit.dart';
import 'package:social_app/shared/cubit/social_cubit/states.dart';
import 'package:social_app/shared/styles/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar:
                defaultAppbar(context: context, title: "New Post", actions: [
              defaultTextButton(
                  function: () {
                    var now = DateTime.now();

                    if (SocialAppCubit.get(context).postImage == null) {
                      SocialAppCubit.get(context).createPost(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    } else {
                      SocialAppCubit.get(context).uploadPostImage(
                        dateTime: now.toString(),
                        text: textController.text,
                      );
                    }
                  },
                  text: "Post"),
              SizedBox(
                width: 5,
              )
            ]),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${SocialAppCubit.get(context).userModel.image}"),
                        radius: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Mohab Sarhan",
                                style: TextStyle(height: 1.3),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: appColor,
                                size: 16,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: "Whats in your mind? ",
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (SocialAppCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              4.0,
                            ),
                            image: DecorationImage(
                              image: FileImage(
                                  SocialAppCubit.get(context).postImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                          onPressed: () {
                            SocialAppCubit.get(context).removePostImage();
                          },
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            SocialAppCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Add Photos"),
                            ],
                          )),
                      TextButton(
                        onPressed: () {},
                        child: Text("# Tags"),
                      ),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
