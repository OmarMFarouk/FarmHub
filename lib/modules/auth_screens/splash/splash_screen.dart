import 'package:farm_hub/logic/chat/chat_cubit.dart';
import 'package:farm_hub/logic/posts/post_cubit.dart';
import 'package:farm_hub/logic/user/user_cubit.dart';
import 'package:farm_hub/modules/layout/layout_screen.dart';
import 'package:farm_hub/shared/styles/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initialDataFetching(context);
    super.initState();
  }

  initialDataFetching(context) async {
    try {
      await BlocProvider.of<UserCubit>(context).fetchUserData();
      await Future.wait([
        BlocProvider.of<PostCubit>(context).fetchInsights(),
        BlocProvider.of<PostCubit>(context).fetchListings(),
        BlocProvider.of<ChatCubit>(context).fetchChats()
      ]);
    } catch (e) {
      print(e.toString());
    }

    BlocProvider.of<PostCubit>(context).generateFeedList();

    AppNavigator.pushR(
        context, const AppLayout(), NavigatorAnimation.fadeAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const Image(
                    image: AssetImage(
                      'asset/images/undraw_fatherhood_-7-i19.png',
                    ),
                    width: 286,
                    height: 210,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'yofarm Hub B2B',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Explore the best deals on farm-fresh produce, sourced directly from farmers.\n\n Let\'s grow partnerships that empower businesses and strengthen communities..',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LinearProgressIndicator(
                    color: Colors.green,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
