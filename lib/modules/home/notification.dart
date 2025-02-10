import 'package:farm_hub/modules/layout/cubit/cubit.dart';
import 'package:farm_hub/modules/layout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Notification',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              child: Image(
                                  image: AssetImage(
                                      'asset/images/Ellipse 131.png')),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Lorem ipsum dolor sit amet consectetur. Faucibus hac bibendum tincidunt nunc',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 3,
                                        backgroundColor: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Oct 04 at 04:23PM',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                SolarIconsBold.menuDots,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          listener: (context, state) {}),
    );
  }
}
