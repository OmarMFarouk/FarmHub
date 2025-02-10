import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_hub/modules/layout/cubit/cubit.dart';
import 'package:farm_hub/modules/layout/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              animationDuration: const Duration(
                milliseconds: 500
              ),
              items: cubit.bottomNav
                  .map((item) => item.icon)
                  .toList(),
              index: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBar(index);
              },
              color: Colors.white,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Colors.white,
              height: 60,
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
