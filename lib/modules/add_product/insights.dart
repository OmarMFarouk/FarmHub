import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:farm_hub/logic/posts/post_cubit.dart';
import 'package:farm_hub/logic/posts/post_states.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:solar_icons/solar_icons.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostStates>(listener: (context, state) {
      if (state is PostFailure) {
        showSnackBar(
            context: context,
            msg: state.msg,
            title: 'Insight Alert',
            type: ContentType.failure);
      }
      if (state is PostSuccess) {
        showSnackBar(
            context: context,
            msg: state.msg,
            title: 'Insight Alert',
            type: ContentType.success);
      }
    }, builder: (context, state) {
      PostCubit cubit = PostCubit.get(context);
      return Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: cubit.insightForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add insights',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Title:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[100],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Empty';
                                }
                                return null;
                              },
                              maxLines: null,
                              controller: cubit.titleCont,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Enter text...',
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700]),
                                suffixIcon: Icon(
                                  Icons.edit_rounded,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Compose Discussion:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[100]),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Empty';
                          }
                          return null;
                        },
                        controller: cubit.bodyCont,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Write a message...',
                          fillColor: Colors.grey[100],
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.grey[700]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Icon(SolarIconsBold.galleryMinimalistic),
                        const SizedBox(
                          width: 2,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 67,
                          height: 26,
                          decoration: BoxDecoration(
                              color: HexColor('#F7F7F7'),
                              borderRadius: BorderRadius.circular(100)),
                          child: const Text('Photo'),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 67,
                          height: 26,
                          decoration: BoxDecoration(
                              color: HexColor('#F7F7F7'),
                              borderRadius: BorderRadius.circular(100)),
                          child: const Text('Video'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < cubit.pickedFiles.length; i++)
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    cubit.pickedFiles.removeAt(i);
                                    cubit.refreshState();
                                  },
                                  child: Ink(
                                    height: 112,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Image(
                                        image: FileImage(
                                            File(cubit.pickedFiles[i].path!))),
                                  ),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        cubit.pickedFiles.length > 5
                            ? const SizedBox()
                            : Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => cubit.pickImage(),
                                  child: Ink(
                                    height: 112,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Colors.grey[400]!)),
                                    child: Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: state is PostLoading ? 10 : 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: defaultColor,
                      ),
                      child: state is PostLoading
                          ? LinearProgressIndicator(
                              color: defaultColor,
                            )
                          : MaterialButton(
                              onPressed: () {
                                if (cubit.insightForm.currentState!
                                    .validate()) {
                                  cubit.createInsight();
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Post Now',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Icon(
                                    FluentIcons.save_28_filled,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
