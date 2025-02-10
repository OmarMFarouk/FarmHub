import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_hub/logic/user/user_cubit.dart';
import 'package:farm_hub/logic/user/user_states.dart';
import 'package:farm_hub/modules/profile/edit/edit.dart';
import 'package:farm_hub/modules/profile/posts_view.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:farm_hub/shared/styles/navigator.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/profiles_model.dart';
import '../../shared/network/remote/user_api.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          UserCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                      onPressed: () {
                        AppNavigator.push(context, const EditScreen(),
                            NavigatorAnimation.fadeAnimation);
                      },
                      icon: const Icon(
                        FluentIcons.edit_settings_24_filled,
                        size: 30,
                      )),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        '@${currentUser!.user!.username}',
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
                          foregroundImage: currentUser!.user!.avatar!.isEmpty
                              ? null
                              : CachedNetworkImageProvider(
                                  currentUser!.user!.avatar!),
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
                      currentUser!.user!.fullName!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      currentUser!.user!.orgName!,
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
                              currentUser!.user!.followCount!,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Follower\'s',
                              style: TextStyle(fontWeight: FontWeight.w500),
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
                              currentUser!.user!.followingCount!,
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
                                  const Icon(
                                      FluentIcons.contact_card_group_16_filled),
                                  Text(
                                    'FAR${(currentUser!.user!.id).toString().padLeft(3, '0')}',
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
                                    currentUser!.user!.location!,
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
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text(
                                'Review',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                        future: UserApi().fetchProfile(
                            userId: currentUser!.user!.id!.toString()),
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
                            ProfilesModel profilesModel =
                                ProfilesModel.fromJson(data);

                            return Column(
                              children: [
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profilesModel.insights!.length,
                                    itemBuilder: (context, index) =>
                                        insightItem(
                                            profilesModel.insights![index]!)),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profilesModel.listings!.length,
                                    itemBuilder: (context, index) =>
                                        listingItem(
                                            profilesModel.listings![index]!))
                              ],
                            );
                          }
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
