import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:farm_hub/logic/posts/post_cubit.dart';
import 'package:farm_hub/logic/user/user_cubit.dart';
import 'package:farm_hub/shared/models/insights_model.dart';
import 'package:farm_hub/shared/network/remote/posts_api.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../modules/chat/conversation.dart';
import '../models/comments_model.dart';
import '../models/listings_model.dart';
import '../styles/color.dart';
import '../styles/navigator.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = 60,
  required Color background,
  double radius = 100,
  required String text,
  required Function() function,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultForm(
        {required String label,
        IconData? prefix,
        required TextInputType type,
        required TextEditingController controller,
        required FormFieldValidator validate,
        Function()? onTap,
        List<FilteringTextInputFormatter>? formatters,
        bool isVisible = false,
        IconData? suffix,
        Function()? suffixPressed,
        Function(String value)? onSubmit,
        bool enable = true,
        Function(String value)? onChange,
        double height = 68,
        double radius = 12}) =>
    Container(
      alignment: Alignment.centerLeft,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.white,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(suffix),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onFieldSubmitted: onSubmit,
        obscureText: isVisible,
        keyboardType: type,
        controller: controller,
        validator: validate,
        onTap: onTap,
        enabled: enable,
        inputFormatters: formatters,
        onChanged: onChange,
      ),
    );

Widget line() => Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 1,
        color: Colors.grey[600],
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

// void showToast({required String msg, ToastState? state}) =>  Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: chooseToastColor(state!),
//     textColor: Colors.white,
//     fontSize: 16.0
// );
//
// //enum
//
// enum ToastState {SUCCESS,ERROR,WARNING}

// Color chooseToastColor(ToastState state){
//   Color color;
//   switch(state)
//   {
//     case ToastState.SUCCESS:
//       color = Colors.green;
//       break;
//     case ToastState.ERROR:
//       color =  Colors.red;
//       break;
//     case ToastState.WARNING:
//       color =  Colors.amber;
//       break;
//   }
//   return color;
// }

Widget listingItem(Listing listing) => Builder(builder: (context) {
      double screenWidth = MediaQuery.of(context).size.width;
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: defaultColor,
                    radius: screenWidth * 0.1,
                    foregroundImage: listing.authorInfo!.avatar!.isEmpty
                        ? null
                        : CachedNetworkImageProvider(
                            listing.authorInfo!.avatar!,
                          ),
                    child: const Icon(
                      FluentIcons.person_20_filled,
                      color: Colors.white,
                      size: 35,
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
                    listing.authorInfo!.fullName!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.047, // Responsive font size
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.grey[400],
                            size: screenWidth * 0.04, // Responsive icon size
                          ),
                          Text(
                            listing.authorInfo!.location!,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize:
                                  screenWidth * 0.035, // Responsive font size
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: screenWidth * 0.005,
                            backgroundColor: Colors.green,
                          ),
                          SizedBox(width: screenWidth * 0.005),
                          Text(
                            listing.authorInfo!.dateCreated!.split(' ').first,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth * 0.03,
                              // Responsive font size
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
              InkWell(
                onTap: () {},
                child: Icon(
                  CupertinoIcons.bookmark,
                  size: screenWidth *
                      0.05, // Optional: adjust icon size if needed
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) =>
                          listing.userId == currentUser!.user!.id.toString()
                              ? ownerMenu(context, listing)
                              : userMenu());
                },
                child: SizedBox(
                  width: 20,
                  height: 20,
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
                        if (i < 2) SizedBox(height: screenWidth * 0.005),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 8, left: 24, bottom: 8, right: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: Row(
              children: [
                Text(
                  listing.title!,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(
                      top: 8, left: 24, bottom: 8, right: 24),
                  decoration: BoxDecoration(
                      color: listing.status! == 'available'
                          ? Colors.green
                          : Colors.black,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    listing.status!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            listing.body!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                      height: 52,
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'UGX ${listing.price!.split('-').first}',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ))),
              const SizedBox(
                width: 8,
              ),
              const Text(
                '-',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Container(
                height: 52,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  'UGX ${listing.price!.split('-').last}',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    listing.files!.isEmpty
                        ? const SizedBox()
                        : Expanded(
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image(
                                height: 240,
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    listing.files!.first!.filelink!),
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    listing.files!.length < 2
                        ? const SizedBox()
                        : Expanded(
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image(
                                    height: 240,
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                        listing.files![1]!.filelink!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          listing.files!.length.toString(),
                                          style: const TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Posted on yofarmhub',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[100]),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          listing.authorInfo!.orgName!,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 44,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.eye_fill,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              listing.views!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Share.share(
                                  'Have a look at listing no. BUY${listing.id} by @${listing.authorInfo!.username} at yofarm Hub App!')
                              .then((r) async {
                            if (r.status == ShareResultStatus.success) {
                              PostsApi().incrementShares(
                                  postId: listing.id.toString(),
                                  postType: 'listing');
                              await BlocProvider.of<PostCubit>(context)
                                  .fetchListings();
                              BlocProvider.of<PostCubit>(context)
                                  .generateFeedList();
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 44,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(100)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FluentIcons.share_android_20_filled,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                listing.shares!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          listing.authorInfo!.id! == currentUser!.user!.id
              ? const SizedBox()
              : defaultButton(
                  background: Colors.black,
                  text: 'Message',
                  function: () {
                    String roomId =
                        '${listing.authorInfo!.username}-${currentUser!.user!.username}';
                    List<String> chars = roomId.split('');
                    chars.sort();
                    String sortedString = chars.join('');
                    String hashedRoomId =
                        md5.convert(sortedString.codeUnits).toString();
                    print(hashedRoomId);
                    AppNavigator.push(
                        context,
                        ConversationScreen(
                          participant: listing.authorInfo,
                          chatRoomId: hashedRoomId,
                          listingId: listing.id!.toString(),
                        ),
                        NavigatorAnimation.fadeAnimation);
                  }),
          const SizedBox(
            height: 20,
          ),
          line()
        ],
      );
    });

Widget listingMenu(String text, IconData icon) => Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Text(text),
      ],
    );

Widget insightItem(Insight insight) => Builder(builder: (context) {
      double screenWidth = MediaQuery.of(context).size.width;
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.1,
                    foregroundImage: insight.authorInfo!.avatar!.isEmpty
                        ? null
                        : CachedNetworkImageProvider(
                            insight.authorInfo!.avatar!),
                    backgroundColor: defaultColor,
                    child: const Icon(
                      FluentIcons.person_20_filled,
                      size: 35,
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
                    insight.authorInfo!.fullName!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.05, // Responsive font size
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.grey[400],
                            size: screenWidth * 0.04, // Responsive icon size
                          ),
                          Text(
                            insight.authorInfo!.location!,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize:
                                  screenWidth * 0.035, // Responsive font size
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: screenWidth * 0.005,
                            backgroundColor: Colors.green,
                          ),
                          SizedBox(width: screenWidth * 0.005),
                          Text(
                            insight.insightDateCreated!.split(' ').first,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth * 0.03,
                              // Responsive font size
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
              InkWell(
                onTap: () {},
                child: Icon(
                  CupertinoIcons.bookmark,
                  size: screenWidth *
                      0.05, // Optional: adjust icon size if needed
                ),
              ),
              const SizedBox(
                width: 14,
              ),
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
          const SizedBox(
            height: 15,
          ),
          Text(
            insight.insightTitle!,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            insight.insightBody!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    await PostsApi().likeInsight(
                        insightId: insight.insightId!.toString(),
                        isLiked: insight.isLiked!);
                    await BlocProvider.of<PostCubit>(context).fetchInsights();
                    BlocProvider.of<PostCubit>(context).generateFeedList();
                  },
                  child: Row(
                    children: [
                      Icon(
                        insight.isLiked!
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        insight.insightLikes!,
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.eye_fill,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      insight.insightViews!,
                      style: TextStyle(color: Colors.grey[600]),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) => CommentModal(
                              insightId: insight.insightId!.toString(),
                            ));
                  },
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.comment_20_filled,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        insight.insightComments!,
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Share.share(
                            'Have a look at this interesting insight by @${insight.authorInfo!.username} at yofarm Hub App!')
                        .then((r) async {
                      if (r.status == ShareResultStatus.success) {
                        PostsApi().incrementShares(
                            postId: insight.insightId.toString(),
                            postType: 'insight');
                        await BlocProvider.of<PostCubit>(context)
                            .fetchInsights();
                        BlocProvider.of<PostCubit>(context).generateFeedList();
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        FluentIcons.share_android_16_filled,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        insight.insightShares!,
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: defaultColor,
                  foregroundImage: currentUser!.user!.avatar!.isEmpty
                      ? null
                      : CachedNetworkImageProvider(currentUser!.user!.avatar!),
                  radius: 17,
                  child: const Icon(
                    FluentIcons.person_20_filled,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) => CommentModal(
                                insightId: insight.insightId!.toString(),
                              ));
                    },
                    child: const TextField(
                      autofocus: false,
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 22),
                        hintText: 'Express your opinion...',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) => CommentModal(
                              insightId: insight.insightId!.toString(),
                            ));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[100]),
                    child: const Text(
                      'Send',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          line()
        ],
      );
    });

Widget back(context) => IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: const Icon(CupertinoIcons.back));

class CommentModal extends StatefulWidget {
  const CommentModal({super.key, required this.insightId});
  final String insightId;

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  TextEditingController commentCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PostsApi().fetchInsightComments(insightId: widget.insightId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
            CommentsModel commentsModel = CommentsModel.fromJson(data);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 6,
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: defaultColor,
                        foregroundImage: currentUser!.user!.avatar!.isEmpty
                            ? null
                            : CachedNetworkImageProvider(
                                currentUser!.user!.avatar!),
                        child: const Icon(
                          FluentIcons.person_20_filled,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: commentCont,
                          decoration: InputDecoration(
                            hintText: 'Express your opinion...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          await PostsApi().addComment(
                              insightId: widget.insightId,
                              commentBody: commentCont.text.trim());
                          setState(() {
                            commentCont.clear();
                          });
                          await BlocProvider.of<PostCubit>(context)
                              .fetchInsights();
                          BlocProvider.of<PostCubit>(context)
                              .generateFeedList();
                        }, // Add send functionality
                      ),
                    ],
                  ),
                  const Divider(height: 20, thickness: 1),

                  // List of comments
                  Expanded(
                    child: ListView.builder(
                      itemCount: commentsModel
                          .insightComments!.length, // Example count
                      itemBuilder: (context, index) => CommentItem(
                          onLike: () async {
                            await PostsApi().commentLike(
                                isLiked: commentsModel
                                    .insightComments![index]!.isLiked!,
                                commentId: commentsModel
                                    .insightComments![index]!.commentid
                                    .toString());

                            setState(() {});
                          },
                          comment: commentsModel.insightComments![index]!),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const LinearProgressIndicator();
          }
        });
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.onLike, required this.comment});
  final InsightComment comment;
  final VoidCallback onLike;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: defaultColor,
                foregroundImage: comment.authorinfo!.avatar!.isEmpty
                    ? null
                    : CachedNetworkImageProvider(comment.authorinfo!.avatar!),
                child: const Icon(
                  FluentIcons.person_20_filled,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('@${comment.authorinfo!.username}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${comment.commentdateCreated}',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment.commentbody!,
            style: TextStyle(color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: Icon(comment.isLiked!
                    ? Icons.thumb_up
                    : Icons.thumb_up_alt_outlined),
                onPressed: onLike, // Add like functionality
              ),
              Text(comment.commentlikes!),
              // const SizedBox(width: 10),
              // const Icon(Icons.comment_outlined),
              // const SizedBox(width: 5),
              // const Text('5 Replies', style: TextStyle(color: Colors.green)),
            ],
          ),
          const Divider(height: 20, thickness: 1),
        ],
      ),
    );
  }
}

Widget ownerMenu(BuildContext context, Listing listing) => FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 6,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            listingMenu('On time line', FluentIcons.timeline_24_regular),
            const SizedBox(
              height: 12,
            ),
            listingMenu('Edit listing', Icons.edit),
            const SizedBox(
              height: 12,
            ),
            listingMenu('Mark a sold', FluentIcons.virtual_network_20_regular),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                listingMenu(
                    'Mark as Booked', FluentIcons.communication_24_regular),
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  CupertinoIcons.checkmark_rectangle_fill,
                  color: defaultColor,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                listingMenu('Listing Id', SolarIconsOutline.billList),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const Text('BUY001'),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              const ClipboardData(text: 'BUY001'));
                          // showToast(msg: 'ID copied to clipboard');
                        },
                        child: Icon(
                          Icons.copy,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
                onTap: () {
                  Share.share(
                          'Have a look at listing no. BUY${listing.id} by @${listing.authorInfo!.username} at yofarm Hub App!')
                      .then((r) async {
                    if (r.status == ShareResultStatus.success) {
                      PostsApi().incrementShares(
                          postId: listing.id.toString(), postType: 'listing');
                      await BlocProvider.of<PostCubit>(context).fetchInsights();
                      BlocProvider.of<PostCubit>(context).generateFeedList();
                    }
                  });
                },
                child:
                    listingMenu('Share', FluentIcons.share_android_20_regular)),
            const SizedBox(
              height: 12,
            ),
            listingMenu('Promote', Icons.campaign_outlined),
          ],
        ),
      ),
    );

Widget userMenu() => FractionallySizedBox(
      heightFactor: 0.4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 6,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            listingMenu('Share listing', FluentIcons.share_android_20_regular),
            const SizedBox(
              height: 12,
            ),
            listingMenu('Report listing', Icons.report_gmailerrorred),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                listingMenu('Listing Id', SolarIconsOutline.billList),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const Text('BUY001'),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              const ClipboardData(text: 'BUY001'));
                          // showToast(msg: 'ID copied to clipboard');
                        },
                        child: Icon(
                          Icons.copy,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
showSnackBar(
    {required BuildContext context,
    required String msg,
    required String title,
    required ContentType type}) {
  Future.delayed(
      const Duration(seconds: 3),
      () => context.mounted
          ? ScaffoldMessenger.of(context).clearMaterialBanners()
          : null);
  return ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(MaterialBanner(
        dividerColor: Colors.transparent,
        actions: const [SizedBox.shrink()],
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 100,
        content: AwesomeSnackbarContent(
            inMaterialBanner: true,
            title: title,
            message: msg,
            contentType: type)));
}
