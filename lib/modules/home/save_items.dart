import 'package:farm_hub/modules/layout/cubit/cubit.dart';
import 'package:farm_hub/modules/layout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

import '../../shared/styles/color.dart';

class SaveItemsScreen extends StatelessWidget {
  const SaveItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Save Item\'s',
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
                            Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Image(
                                  image: AssetImage(
                                      'asset/images/Rectangle 29.png')),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '(Chicken)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: defaultColor),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 12,
                                        width: 2,
                                        color: Colors.grey[200],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'UGX 25,000',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 7,
                                        backgroundColor: Colors.green[100],
                                        child: CircleAvatar(
                                          radius: 4,
                                          backgroundColor: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Available',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.place,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Buikwe , Kasubi',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
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
