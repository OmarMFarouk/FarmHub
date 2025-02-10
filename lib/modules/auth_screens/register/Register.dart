import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:farm_hub/logic/auth/auth_cubit.dart';
import 'package:farm_hub/logic/auth/auth_states.dart';
import 'package:farm_hub/modules/auth_screens/splash/splash_screen.dart';
import 'package:farm_hub/shared/styles/navigator.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/color.dart';
import '../login/login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Container(
            color: Colors.grey[100],
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: cubit.registerForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'YoFarm Hub',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    'Enter your Sign Up information below',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                alignment: FractionalOffset.topRight,
                                children: [
                                  Container(
                                    height: 110,
                                    width: 110,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          color: defaultColor,
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.add,
                                        color: CupertinoColors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultForm(
                          label: 'Enter your Full name',
                          prefix: FontAwesomeIcons.circleUser,
                          type: TextInputType.text,
                          controller: cubit.nameCont,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        defaultForm(
                          label: 'Enter your Email',
                          prefix: FontAwesomeIcons.envelope,
                          type: TextInputType.text,
                          controller: cubit.emailCont,
                          formatters: [FilteringTextInputFormatter.deny(' ')],
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Empty';
                            }
                            if (!value.contains('@') ||
                                value.endsWith('@') ||
                                value.startsWith('@')) {
                              return 'Invalid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        defaultForm(
                          label: 'Enter your Business name',
                          prefix: Icons.add_home_work_outlined,
                          type: TextInputType.emailAddress,
                          controller: cubit.orgNameCont,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultForm(
                          label: 'Enter your location',
                          prefix: CupertinoIcons.location_solid,
                          type: TextInputType.text,
                          controller: cubit.locationCont,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultForm(
                          label: 'Enter your Phone',
                          prefix: CupertinoIcons.phone,
                          type: TextInputType.visiblePassword,
                          controller: cubit.phoneCont,
                          formatters: [FilteringTextInputFormatter.deny(' ')],
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Empty';
                            } else if (value.length < 9) {
                              return 'Invalid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultForm(
                          label: 'Enter your Password',
                          prefix: FluentIcons.password_16_regular,
                          type: TextInputType.visiblePassword,
                          controller: cubit.passwordCont,
                          formatters: [FilteringTextInputFormatter.deny(' ')],
                          suffix: cubit.isVisible
                              ? FluentIcons.eye_off_24_filled
                              : FluentIcons.eye_24_filled,
                          suffixPressed: () {
                            cubit.togglePassword();
                          },
                          isVisible: cubit.isVisible,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Empty';
                            } else if (value.length < 6) {
                              return 'Short Password.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state is AuthLoading
                            ? LinearProgressIndicator(
                                color: Colors.greenAccent[500],
                              )
                            : defaultButton(
                                height: 58,
                                radius: 100,
                                background: defaultColor,
                                text: 'Sign up',
                                function: () {
                                  if (cubit.registerForm.currentState!
                                      .validate()) {
                                    cubit.registerUser();
                                  }
                                }),
                        const SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   height: 68,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12),
                        //     color: CupertinoColors.white
                        //   ),
                        //   child: const Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         FontAwesomeIcons.google,
                        //         color: Colors.red,
                        //       ),
                        //       SizedBox(width: 10,),
                        //       Text(
                        //         'Continue with Google',
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 16
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Container(
                        //   height: 68,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(12),
                        //       color: CupertinoColors.white
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         FontAwesomeIcons.facebook,
                        //         color: HexColor('#1877F2'),
                        //       ),
                        //       const SizedBox(width: 10,),
                        //       const Text(
                        //         'Continue with Facebook',
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 16
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateAndFinish(
                                      context, const LoginScreen());
                                },
                                child: Text(
                                  'Login',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthError) {
            showSnackBar(
                title: 'Authentication Error',
                context: context,
                msg: state.msg,
                type: ContentType.failure);
          }
          if (state is AuthSuccess) {
            AppNavigator.pushR(context, const SplashScreen(),
                NavigatorAnimation.slideAnimation);
          }
        },
      ),
    );
  }
}
