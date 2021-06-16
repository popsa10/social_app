import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/social_register_cubit/states.dart';
import 'package:social_app/shared/styles/constants.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {@required email,
      @required password,
      @required name,
      @required phone}) async {
    emit(SocialRegisterLoadingState());
    var token = await FirebaseMessaging.instance.getToken();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userData(value.user.uid, name, email, phone, token);
      emit(SocialRegisterSuccessState(value.user.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userData(String id, String name, String email, String phone, token) {
    SocialUserModel model = SocialUserModel(
        email: email,
        phone: phone,
        name: name,
        bio: "write your bio ...",
        cover: "https://image.freepik.com/free-vector/group-man_1284-12615.jpg",
        isEmailVerified: false,
        image:
            "https://img.freepik.com/free-photo/serious-man-thinking_1149-1328.jpg?size=338&ext=jpg",
        uId: id,
        token: token);

    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(model.toMap())
        .then((value) {
      emit(SocialRegisterSaveDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterSaveDataErrorState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordState());
  }
}
