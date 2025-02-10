import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:farm_hub/logic/auth/auth_cubit.dart';
import 'package:farm_hub/logic/auth/auth_states.dart';
import 'package:farm_hub/modules/auth_screens/register/Register.dart';
import 'package:farm_hub/modules/auth_screens/submit_code/submit_code.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/styles/color.dart';
import '../../../shared/styles/navigator.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        if (state is AuthError) {
          showSnackBar(
              title: 'Authentication Error',
              context: context,
              msg: state.msg,
              type: ContentType.failure);
        }
        if (state is AuthSuccess) {
          AppNavigator.pushR(context, const SubmitCodeScreen(),
              NavigatorAnimation.slideAnimation);
        }
      }, builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: cubit.forgetForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Forget Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'To reset your password, you need your email or mobile number that can be authenticated',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: HexColor('#282828'),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text(
                                'Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     decoration: BoxDecoration(
                          //       color: Colors.transparent,
                          //       borderRadius: BorderRadius.circular(100),
                          //     ),
                          //     child: const Text(
                          //       'Phone',
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: 16),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultForm(
                        label: 'Enter your email ',
                        prefix: FontAwesomeIcons.circleUser,
                        type: TextInputType.emailAddress,
                        controller: credentialCont,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Empty';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultButton(
                        background: defaultColor,
                        height: 58,
                        radius: 100,
                        text: 'Send Code',
                        function: () {
                          if (cubit.forgetForm.currentState!.validate()) {
                            cubit.handleOTP();
                          }
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 68,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: CupertinoColors.white),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 68,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: CupertinoColors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.facebook,
                            color: HexColor('#1877F2'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Continue with Facebook',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                            onPressed: () {
                              navigateAndFinish(context, RegisterScreen());
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
      }),
    );
  }
}
