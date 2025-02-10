
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// import '../../models/social_app/post_model.dart';
//
// class ImageViewerScreen extends StatelessWidget {
//   final SocialPostModel postModel;
//
//   const ImageViewerScreen({Key? key, required this.postModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: PhotoView(
//         imageProvider: NetworkImage(postModel.postImage!), // Use your post image URL
//         heroAttributes: const PhotoViewHeroAttributes(tag: 'imageHero'),
//         backgroundDecoration: BoxDecoration(
//           color: CupertinoColors.transparent,
//
//         ),
//       ),
//     );
//   }
// }
