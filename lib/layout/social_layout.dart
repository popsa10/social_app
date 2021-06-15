import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/new_post_screen.dart';
import 'package:social_app/shared/components/defaults.dart';
import 'package:social_app/shared/cubit/social_cubit/cubit.dart';
import 'package:social_app/shared/cubit/social_cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {
      if (state is SocialNewPostState)
        navigateTo(context: context, page: NewPostScreen());
    }, builder: (context, state) {
      SocialAppCubit cubit = SocialAppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(icon: Icon(IconBroken.Notification), onPressed: () {}),
            IconButton(icon: Icon(IconBroken.Search), onPressed: () {}),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: cubit.bottomItems,
          currentIndex: cubit.currentIndex,
          onTap: (value) {
            cubit.changeBottomNav(value);
          },
        ),
      );
    });
  }
}
