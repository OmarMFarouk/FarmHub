import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:farm_hub/logic/auth/auth_cubit.dart';
import 'package:farm_hub/logic/auth/auth_states.dart';
import 'package:farm_hub/modules/auth_screens/forget_password/forget_password.dart';
import 'package:farm_hub/modules/auth_screens/splash/splash_screen.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/navigator.dart';
import '../register/Register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: cubit.loginForm,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        'YoFarm Hub',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Enter your credential to Login',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultForm(
                          label: 'Enter your username or email',
                          prefix: FontAwesomeIcons.circleUser,
                          type: TextInputType.emailAddress,
                          controller: credentialCont,
                          formatters: [FilteringTextInputFormatter.deny(' ')],
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Empty';
                            }

                            return null;
                          }),
                      const SizedBox(
                        height: 8,
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
                              return 'Short Password';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      state is AuthLoading
                          ? const LinearProgressIndicator(
                              color: Colors.green,
                            )
                          : defaultButton(
                              background: defaultColor,
                              height: 58,
                              radius: 100,
                              text: 'Login',
                              function: () {
                                if (cubit.loginForm.currentState!.validate()) {
                                  cubit.loginUser();
                                }
                              }),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {
                              navigateTo(context, const ForgetPasswordScreen());
                            },
                            child: Text(
                              'Forget password?',
                              style: Theme.of(context).textTheme.labelMedium,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextButton(
                              onPressed: () {
                                navigateAndFinish(
                                    context, const RegisterScreen());
                              },
                              child: Text(
                                'Sign Up',
                                style: Theme.of(context).textTheme.labelMedium,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }, listener: (context, state) {
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
        }));
  }
}
