
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsViewScreen extends StatelessWidget {
  const PostsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> postsImages = [
      const Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(image: AssetImage('asset/images/Frame 599.png'),
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
      const Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(image: AssetImage('asset/images/Frame 599 (1).png'),
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
      const Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(image: AssetImage('asset/images/Frame 599 (2).png'),
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
      const Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(image: AssetImage('asset/images/Frame 599 (3).png'),
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
      const Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(image: AssetImage('asset/images/Frame 599 (4).png'),
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
      const Card(
        color: Colors.white,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image(image: AssetImage('asset/images/Frame 599 (5).png'),
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: const Icon(
              CupertinoIcons.back
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated(
              physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>postsImages[index],
                separatorBuilder: (context,index)=>const SizedBox(height: 24,),
                itemCount: postsImages.length)
            )
          ],
        ),
      ),
    );
  }
}
