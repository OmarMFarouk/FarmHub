import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:farm_hub/modules/auth_screens/new_password/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/auth/auth_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/color.dart';
import '../../../shared/styles/navigator.dart';

class SubmitCodeScreen extends StatelessWidget {
  const SubmitCodeScreen({super.key});

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
            AppNavigator.pushR(context, const NewPasswordScreen(),
                NavigatorAnimation.slideAnimation);
          }
        }, builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: cubit.pinForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        'Verification Code',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Collect the code from your email address and enter it\n${credentialCont.text}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 100),
                      Center(
                          child: Pinput(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.length != 4) {
                            return '*Empty';
                          }
                          return null;
                        },
                        controller: cubit.pinCont,
                      )),
                      const SizedBox(height: 24),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: List.generate(
                      //       4, (index) => _buildCodeField(context)),
                      // ),
                      const SizedBox(
                        height: 24,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Don\'nt received code?',
                      //       style: Theme.of(context).textTheme.bodyMedium,
                      //     ),
                      //     TextButton(
                      //         onPressed: () {},
                      //         child: Text(
                      //           'Send again',
                      //           style: Theme.of(context).textTheme.labelMedium,
                      //         ))
                      //   ],
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultButton(
                          background: defaultColor,
                          height: 58,
                          radius: 100,
                          text: 'Submit',
                          function: () {
                            if (cubit.pinForm.currentState!.validate()) {
                              cubit.checkOTP();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget _buildCodeField(BuildContext context) {
    return Container(
      width: 60,
      decoration:
          BoxDecoration(color: Colors.grey[350], shape: BoxShape.circle),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          fillColor: Colors.white,
          label: const Text(''),
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 40,
          ),
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
