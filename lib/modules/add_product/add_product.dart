import 'package:farm_hub/modules/add_product/insights.dart';
import 'package:farm_hub/modules/add_product/listing.dart';
import 'package:farm_hub/modules/layout/cubit/cubit.dart';
import 'package:farm_hub/modules/layout/cubit/state.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) => Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateTo(context, const ListingScreen());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: defaultColor,
                              width: 2),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              FluentIcons.task_list_square_add_20_regular,
                              size: 60,
                              color: defaultColor,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              'Add Listing',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateTo(context, const InsightsScreen());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: defaultColor,
                              width: 2),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.add_comment_outlined,
                              size: 60,
                              color: defaultColor,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              'Add Insights',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        listener: (context, state) {});
  }
}
