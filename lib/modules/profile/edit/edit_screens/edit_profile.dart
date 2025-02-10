import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_hub/logic/user/user_states.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../logic/user/user_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is UserSuccess) {
        showSnackBar(
            context: context,
            msg: state.msg,
            title: 'Profile Alert',
            type: ContentType.success);
      }
      if (state is UserFailure) {
        showSnackBar(
            context: context,
            msg: state.msg,
            title: 'Profile Alert',
            type: ContentType.failure);
      }
    }, builder: (context, state) {
      UserCubit cubit = UserCubit.get(context);
      return Scaffold(
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
                  'Edit Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: defaultColor,
                      foregroundImage: cubit.pickedImage == null
                          ? null
                          : FileImage(File(cubit.pickedImage!.path!)),
                      backgroundImage: currentUser!.user!.avatar!.isEmpty
                          ? null
                          : CachedNetworkImageProvider(
                              currentUser!.user!.avatar!),
                      child: currentUser!.user!.avatar!.isEmpty
                          ? const Icon(
                              FluentIcons.person_20_filled,
                              size: 55,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () => cubit.pickImage(),
                            icon: const Icon(
                              FluentIcons.camera_28_regular,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                defaultForm(
                    label: currentUser!.user!.fullName!,
                    type: TextInputType.name,
                    prefix: FontAwesomeIcons.userLarge,
                    suffix: Icons.edit,
                    controller: cubit.fullNameCont,
                    validate: (value) {
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                defaultForm(
                    label: '@${currentUser!.user!.username!}',
                    type: TextInputType.text,
                    prefix: FontAwesomeIcons.userLarge,
                    suffix: Icons.edit,
                    enable: false,
                    controller: TextEditingController(),
                    validate: (value) {
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                defaultForm(
                    label: currentUser!.user!.phone!,
                    type: TextInputType.phone,
                    prefix: FluentIcons.phone_48_filled,
                    suffix: Icons.edit,
                    controller: cubit.phoneCont,
                    validate: (value) {
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                defaultForm(
                    label: currentUser!.user!.email!,
                    type: TextInputType.emailAddress,
                    prefix: FluentIcons.mail_all_read_28_filled,
                    suffix: Icons.edit,
                    controller: cubit.emailCont,
                    validate: (value) {
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                defaultForm(
                    label: currentUser!.user!.orgName!,
                    type: TextInputType.text,
                    prefix: Icons.business_rounded,
                    suffix: Icons.edit,
                    controller: cubit.orgNameCont,
                    validate: (value) {
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: defaultButton(
                      background: defaultColor,
                      text: 'Save change',
                      function: () {
                        cubit.editUserProfile();
                      }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
