import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_hub/logic/chat/chat_cubit.dart';
import 'package:farm_hub/logic/chat/chat_states.dart';
import 'package:farm_hub/modules/chat/conversation.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:farm_hub/shared/styles/navigator.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<ChatCubit, ChatStates>(
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FluentIcons.info_48_filled,
                        color: Colors.black,
                      )),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Chat List',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: defaultColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Hello, Harrison',
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 4,
                                width: 4,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: 4,
                                width: 4,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: 4,
                                width: 4,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  defaultForm(
                      height: 50,
                      radius: 100,
                      label: 'Search',
                      prefix: CupertinoIcons.search,
                      type: TextInputType.text,
                      controller: searchController,
                      validate: (value) {
                        return null;
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                AppNavigator.push(
                                    context,
                                    ConversationScreen(
                                      participant: cubit.chatsModel!
                                          .chats![index]!.participantInfo,
                                      chatRoomId:
                                          cubit.chatsModel!.chats![index]!.id!,
                                    ),
                                    NavigatorAnimation.fadeAnimation);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: CupertinoColors.white),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: defaultColor,
                                      foregroundImage: cubit
                                              .chatsModel!
                                              .chats![index]!
                                              .participantInfo!
                                              .avatar!
                                              .isEmpty
                                          ? null
                                          : CachedNetworkImageProvider(cubit
                                              .chatsModel!
                                              .chats![index]!
                                              .participantInfo!
                                              .avatar!),
                                      child: const Icon(
                                        FluentIcons.person_20_filled,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          cubit.chatsModel!.chats![index]!
                                              .participantInfo!.fullName!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          cubit.chatsModel!.chats![index]!
                                              .lastMsg!,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 2,
                                              width: 2,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              height: 2,
                                              width: 2,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Container(
                                              height: 2,
                                              width: 2,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          cubit.chatsModel!.chats![index]!
                                              .dateUpdated!,
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: cubit.chatsModel!.chats!.length),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
