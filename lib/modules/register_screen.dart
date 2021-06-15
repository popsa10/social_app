import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/networks/local/cache_helper.dart';
import 'package:social_app/shared/components/defaults.dart';
import 'package:social_app/shared/cubit/social_register_cubit/cubit.dart';
import 'package:social_app/shared/cubit/social_register_cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterErrorState) {
            showToast(text: state.error, color: Colors.red);
          } else if (state is SocialRegisterSuccessState) {
            CacheHelper.setData(key: "token", value: state.userId)
                .then((value) {
              navigateToAndFinish(context: context, page: SocialAppLayout());
            });
          }
        },
        builder: (context, state) {
          SocialRegisterCubit cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "register".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "register now to communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            label: "User Name",
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "Name Must Not Be Empty";
                              }
                            },
                            prefix: Icons.person,
                            type: TextInputType.name),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: emailController,
                          label: "Email",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Email Must Not Be Empty";
                            }
                          },
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          suffix: cubit.suffix,
                          suffixFunction: () {
                            cubit.changePasswordVisibility();
                          },
                          isPassword: cubit.isPassword,
                          controller: passwordController,
                          label: "Password",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Password is too short";
                            }
                          },
                          prefix: Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          label: "Phone",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Phone Must Not Be Empty";
                            }
                          },
                          prefix: Icons.phone,
                          type: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                              text: "register",
                              function: () {
                                if (formKey.currentState.validate()) {
                                  cubit.userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              }),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
