import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_hub/logic/chat/chat_cubit.dart';
import 'package:farm_hub/logic/chat/chat_states.dart';
import 'package:farm_hub/modules/chat/conversation_info/coversation_info.dart';
import 'package:farm_hub/modules/chat/voice_note.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/models/chats_model.dart';
import 'package:farm_hub/shared/models/user_model.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../logic/user/user_cubit.dart';
import '../../shared/styles/navigator.dart';
import '../user_profile/user_profile.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen(
      {super.key, this.participant, required this.chatRoomId, this.listingId});
  final String chatRoomId;
  final User? participant;
  final String? listingId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
        bloc: ChatCubit.get(context).readMessage(roomId: chatRoomId),
        listener: (context, state) {},
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          Chat? currentChat = cubit.chatsModel!.chats!
              .firstWhere((element) => element!.id == chatRoomId, orElse: () {
            return Chat(participantInfo: participant, messages: []);
          });

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back),
              ),
              title: Text(
                '@${participant!.username!}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#1DB954')),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          ConversationInfoScreen(
                              chatRoomId: chatRoomId, userInfo: participant!));
                    },
                    child: const Icon(
                      CupertinoIcons.info_circle_fill,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppNavigator.push(
                            context,
                            UserProfileScreen(
                                userId: participant!.id.toString()),
                            NavigatorAnimation.fadeAnimation);
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: defaultColor,
                        foregroundImage: participant!.avatar!.isEmpty
                            ? null
                            : CachedNetworkImageProvider(participant!.avatar!),
                        child: const Icon(
                          FluentIcons.person_20_filled,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      participant!.fullName!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Location - ${participant!.location}',
                    ),
                    const Text(
                      'Interest - Fruits, Vegetable’s\n Livestock and grain',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    listingId == null
                        ? const SizedBox()
                        : Container(
                            width: 77,
                            height: 32,
                            decoration: BoxDecoration(
                              color: HexColor('#1976D2'),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'BUY${listingId!.padLeft(3, '0')}',
                              style:
                                  const TextStyle(color: CupertinoColors.white),
                            ),
                          ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    controller: cubit.scrollCont,
                    itemCount: currentChat!.messages!.length,
                    itemBuilder: (context, index) {
                      final message = currentChat!.messages![index];
                      return Align(
                        alignment:
                            message!.userId == currentUser!.user!.id!.toString()
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: Message().userId ==
                                  currentUser!.user!.id!.toString()
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: message.status == 'deleted'
                                    ? Colors.red
                                    : message.userId ==
                                            currentUser!.user!.id!.toString()
                                        ? Colors.blueAccent
                                        : Colors.grey[200],
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Text(
                                message.status == 'deleted'
                                    ? '[DELETED]'
                                    : message.body!,
                                style: TextStyle(
                                  color: message.userId ==
                                          currentUser!.user!.id!.toString()
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                message.dateCreated!,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[500]),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 15,
                          spreadRadius: 5,
                        )
                      ]),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        child: IconButton(
                          icon: const Icon(SolarIconsBold.galleryRound),
                          onPressed: () {
                            // Add your camera function
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(CupertinoIcons.mic),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const VoiceNoteScreen());
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: cubit.msgFocus,
                          controller: cubit.msgController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Write a message...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CircleAvatar(
                        backgroundColor: CupertinoColors.white,
                        radius: 25,
                        child: ValueListenableBuilder(
                          valueListenable: cubit.msgController,
                          builder: (context, value, child) => IconButton(
                              icon: Icon(FluentIcons.send_24_filled,
                                  color: cubit.msgController.text.isEmpty
                                      ? Colors.grey
                                      : defaultColor),
                              onPressed: cubit.msgController.text.isEmpty
                                  ? null
                                  : () => cubit.sendMessage(
                                      roomId: chatRoomId,
                                      participantId: currentChat!
                                          .participantInfo!.id!
                                          .toString())),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
