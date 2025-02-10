import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_hub/modules/user_profile/reviews.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/models/profiles_model.dart';
import 'package:farm_hub/shared/network/remote/user_api.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: back(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FutureBuilder(
              future: UserApi().fetchProfile(userId: userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: LinearProgressIndicator(
                      backgroundColor: defaultColor,
                    ),
                  );
                } else {
                  Map<String, dynamic> data =
                      snapshot.data as Map<String, dynamic>;
                  ProfilesModel profilesModel = ProfilesModel.fromJson(data);
                  return Column(
                    children: [
                      Center(
                        child: Text(
                          '@${profilesModel.userdata!.username}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: defaultColor),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: defaultColor,
                            foregroundImage:
                                profilesModel.userdata!.avatar!.isEmpty
                                    ? null
                                    : CachedNetworkImageProvider(
                                        profilesModel.userdata!.avatar!),
                            child: const Icon(
                              FluentIcons.person_20_filled,
                              size: 55,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(17),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: CupertinoColors.white,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.green[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        profilesModel.userdata!.fullName!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        profilesModel.userdata!.orgName!,
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                profilesModel.userdata!.followCount!,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Follower\'s',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                          ),
                          Column(
                            children: [
                              Text(
                                profilesModel.userdata!.followingCount!,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Following\'s',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Icon(FluentIcons
                                        .contact_card_group_16_filled),
                                    Text(
                                      'BUY${profilesModel.userdata!.id.toString().padLeft(3, '0')}',
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: const Column(
                                  children: [
                                    Icon(FluentIcons.live_24_filled),
                                    Text(
                                      'Livestock',
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Icon(FluentIcons.location_20_filled),
                                    Text(
                                      profilesModel.userdata!.location!,
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: defaultButton(
                                height: 58,
                                background: defaultColor,
                                text: 'Follow',
                                function: () {}),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                height: 58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white),
                                child: const Icon(Icons.message_outlined),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                height: 58,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Column(
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
                                      if (i < 2)
                                        SizedBox(height: screenWidth * 0.005),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.all(4),
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
                                  color: defaultColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Text(
                                  'Timeline',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigateTo(context, const ReviewScreen());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text(
                                    'Review',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: profilesModel.insights!.length,
                          itemBuilder: (context, index) =>
                              insightItem(profilesModel.insights![index]!))
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
