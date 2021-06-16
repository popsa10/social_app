import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login_screen.dart';
import 'package:social_app/networks/local/cache_helper.dart';
import 'package:social_app/networks/remote/dio_helper.dart';
import 'package:social_app/shared/components/defaults.dart';
import 'package:social_app/shared/cubit/social_cubit/cubit.dart';
import 'package:social_app/shared/styles/bloc_observer.dart';
import 'package:social_app/shared/styles/constants.dart';

import 'layout/social_layout.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(text: "background notification", color: Colors.green);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: "onMessage notification", color: Colors.green);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: "onMessageOpenedApp notification", color: Colors.green);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  userId = CacheHelper.getData("token");
  Bloc.observer = MyBlocObserver();
  Widget widget;
  if (userId != null)
    widget = SocialAppLayout();
  else
    widget = LoginScreen();
  runApp(MyApp(
    start: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget start;
  const MyApp({Key key, this.start});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppCubit()
        ..getPosts()
        ..getUserData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Social App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home: start),
    );
  }
}
