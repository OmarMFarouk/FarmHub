import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_hub/modules/chat/conversation_info/report.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/models/user_model.dart';

class ConversationInfoScreen extends StatelessWidget {
  const ConversationInfoScreen(
      {super.key, required this.userInfo, required this.chatRoomId});
  final User userInfo;
  final String chatRoomId;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back, size: screenWidth * 0.06),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.info_circle_fill,
                color: Colors.black, size: screenWidth * 0.06),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conversation Info',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.06,
                  color: defaultColor,
                ),
              ),
              SizedBox(height: screenWidth * 0.1),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CupertinoColors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.125,
                          backgroundColor: defaultColor,
                          foregroundImage: userInfo.avatar!.isEmpty
                              ? null
                              : CachedNetworkImageProvider(userInfo.avatar!),
                          child: const Icon(
                            FluentIcons.person_20_filled,
                            size: 55,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.015),
                          child: CircleAvatar(
                            radius: screenWidth * 0.02,
                            backgroundColor: CupertinoColors.white,
                            child: CircleAvatar(
                              radius: screenWidth * 0.017,
                              backgroundColor: Colors.green[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userInfo.fullName!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.01),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.grey[400],
                              size: screenWidth * 0.04,
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              userInfo.location!,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: screenWidth * 0.005,
                                  backgroundColor: Colors.green,
                                ),
                                SizedBox(width: screenWidth * 0.005),
                                Text(
                                  'following',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth * 0.03,
                                    color: defaultColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 3; i++) ...[
                          Container(
                            height: screenWidth * 0.01,
                            width: screenWidth * 0.01,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                          if (i < 2) SizedBox(height: screenWidth * 0.005),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CupertinoColors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Notification’s',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Snooze notification’s from user',
                          style: TextStyle(color: Colors.grey[400]),
                        )
                      ],
                    ),
                    const Spacer(),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          width: 40,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 12,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    isScrollControlled: true, // Allows setting custom height
                    builder: (context) => FractionallySizedBox(
                      heightFactor: 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Container(
                                height: 8,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Block ${userInfo.fullName}. ${userInfo.fullName} will no longer be able to follow or message you, and you will not see notifications from ${userInfo.fullName}.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            defaultButton(
                              background: HexColor('#282828'),
                              text: 'Block ${userInfo.fullName}',
                              function: () {},
                              height: 58,
                            ),
                            const SizedBox(height: 24),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 58,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white,
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: containerItem(
                    'Block ${userInfo.fullName}!', Icons.block_flipped),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  navigateTo(context, const ReportScreen());
                },
                child: containerItem(
                    'Report ${userInfo.fullName}!', Icons.report_gmailerrorred),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      context: context,
                      isScrollControlled: true, // Allows setting custom height
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Container(
                                  height: 8,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'You\'ve successfully unfollowed ${userInfo.fullName}. While their listing won\'t appear in your timeline, you can still view their profile.Leave Cancel',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              defaultButton(
                                background: Colors.red,
                                text: 'Leave',
                                function: () {},
                                height: 58,
                              ),
                              const SizedBox(height: 24),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 58,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: containerItem(
                      'Leave Conversation!', Icons.output_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget containerItem(String text, IconData icon) => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: CupertinoColors.white,
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 16,
          ),
          Text(text)
        ],
      ),
    );
