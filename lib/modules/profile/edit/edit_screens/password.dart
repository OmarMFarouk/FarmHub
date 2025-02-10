import 'package:farm_hub/modules/layout/cubit/cubit.dart';
import 'package:farm_hub/modules/layout/cubit/state.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var newPasswordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) => Scaffold(
                appBar: AppBar(
                  leading: back(context),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Change password',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 32),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        defaultForm(
                            label: 'Enter new Password',
                            type: TextInputType.visiblePassword,
                            prefix: FluentIcons.password_48_regular,
                            suffix: AppCubit.get(context).suffix,
                            suffixPressed: () {
                              AppCubit.get(context).changePass();
                            },
                            isVisible: AppCubit.get(context).isPassword,
                            controller: newPasswordController,
                            validate: (value) {
                              return null;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultForm(
                            label: '@Confirm Password',
                            type: TextInputType.visiblePassword,
                            prefix: FluentIcons.password_48_regular,
                            suffix: AppCubit.get(context).suffixConfirm,
                            suffixPressed: () {
                              AppCubit.get(context).changeConfirmPass();
                            },
                            isVisible: AppCubit.get(context).isConfirmPassword,
                            controller: confirmPasswordController,
                            validate: (value) {
                              return null;
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultButton(
                            background: defaultColor,
                            text: 'Reset Password',
                            function: () {})
                      ],
                    ),
                  ),
                ),
              ),
          listener: (context, state) {}),
    );
  }
}
