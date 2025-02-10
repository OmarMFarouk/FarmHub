import 'package:farm_hub/logic/posts/post_cubit.dart';
import 'package:farm_hub/logic/posts/post_states.dart';
import 'package:farm_hub/modules/layout/cubit/cubit.dart';
import 'package:farm_hub/modules/layout/cubit/state.dart';
import 'package:farm_hub/modules/home/notification.dart';
import 'package:farm_hub/modules/home/save_items.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/models/insights_model.dart';
import 'package:farm_hub/shared/network/remote/posts_api.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../shared/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) => BlocConsumer<PostCubit, PostStates>(
            listener: (context, state) {},
            builder: (context, state) {
              PostCubit cubit = PostCubit.get(context);
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize:
                      const Size.fromHeight(70), // Set the height of the AppBar
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(8)), // Add bottom radius
                    child: AppBar(
                      backgroundColor: defaultColor,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.light,
                        statusBarColor: defaultColor,
                      ),
                      title: const Text(
                        'yofarm Hub B2B',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center icons horizontally
                          children: [
                            IconButton(
                              onPressed: () {
                                navigateTo(context, const NotificationScreen());
                              },
                              icon: const Icon(
                                CupertinoIcons.bell_fill,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                navigateTo(context, const SaveItemsScreen());
                              },
                              icon: const Icon(
                                CupertinoIcons.bookmark,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubit.feedList.length,
                      itemBuilder: (context, index) {
                        if (cubit.feedList[index] is Insight) {
                          return VisibilityDetector(
                              onVisibilityChanged: (visibilityInfo) {
                                if (visibilityInfo.visibleFraction > 0.6 &&
                                    !CacheHelper.sharedPreferences
                                        .getStringList('insights_history')!
                                        .contains(cubit
                                            .feedList[index].insightId
                                            .toString())) {
                                  List<String> originalList = CacheHelper
                                      .sharedPreferences
                                      .getStringList('insights_history')!;
                                  originalList.add(cubit
                                      .feedList[index].insightId
                                      .toString());
                                  CacheHelper.sharedPreferences.setStringList(
                                      'insights_history', originalList);
                                  PostsApi().incrementViews(
                                      postType: 'insight',
                                      postId: cubit.feedList[index].insightId
                                          .toString());
                                }
                              },
                              key: Key('post_$index'),
                              child: insightItem(cubit.feedList[index]));
                        } else {
                          return VisibilityDetector(
                              onVisibilityChanged: (visibilityInfo) {
                                if (visibilityInfo.visibleFraction > 0.6 &&
                                    !CacheHelper.sharedPreferences
                                        .getStringList('listings_history')!
                                        .contains(cubit.feedList[index].id
                                            .toString())) {
                                  List<String> originalList = CacheHelper
                                      .sharedPreferences
                                      .getStringList('listings_history')!;
                                  originalList
                                      .add(cubit.feedList[index].id.toString());
                                  CacheHelper.sharedPreferences.setStringList(
                                      'listings_history', originalList);

                                  PostsApi().incrementViews(
                                      postType: 'listing',
                                      postId:
                                          cubit.feedList[index].id.toString());
                                }
                              },
                              key: Key('post_$index'),
                              child: listingItem(cubit.feedList[index]));
                        }
                      },
                    ),
                  ),
                ),
              );
            }),
        listener: (context, state) {});
  }
}
