import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/auth/auth_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/color.dart';
import '../../../shared/styles/navigator.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
          showSnackBar(
              title: state.msg,
              context: context,
              msg: state.msg,
              type: ContentType.success);
          AppNavigator.pop(context);
        }
      }, builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Set a new password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Set up a strong password for your security. Use a minimum of 8 letters, numbers, alphabets, symbols to make your password strong',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 40),
                    defaultForm(
                      label: 'Enter new Password',
                      prefix: FluentIcons.password_16_regular,
                      type: TextInputType.visiblePassword,
                      formatters: [FilteringTextInputFormatter.deny(' ')],
                      controller: newPasswordController,
                      isVisible: true,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Empty';
                        } else if (value.length < 6) {
                          return 'Short length.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    defaultForm(
                      label: 'Confirm Password',
                      prefix: FluentIcons.password_16_regular,
                      type: TextInputType.visiblePassword,
                      formatters: [FilteringTextInputFormatter.deny(' ')],
                      controller: confirmPasswordController,
                      isVisible: true,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Empty';
                        } else if (value.length < 6) {
                          return 'Short length.';
                        } else if (value != newPasswordController.text) {
                          return 'Password mismatch.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        background: defaultColor,
                        height: 58,
                        radius: 100,
                        text: 'Reset Password',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.changePassword(
                                password: newPasswordController.text.trim());
                          }
                        }),
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
