


import 'package:farm_hub/modules/layout/cubit/cubit.dart';
import 'package:farm_hub/modules/layout/cubit/state.dart';
import 'package:farm_hub/shared/components/components.dart';
import 'package:farm_hub/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) =>
              Scaffold(
                appBar: AppBar(
                  leading: back(context),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600
                          ),

                        ),
                        const SizedBox(height: 20,),
                        DropdownMenu(
                          hintText: 'Country Name: Ugandan',
                            width: double.infinity,
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: 'Ugandan', label: 'Ugandan'),
                              DropdownMenuEntry(value: 'Egypt', label: 'Egypt'),
                              DropdownMenuEntry(value: 'Palatine', label: 'Palatine'),
                            ],
                        ),
                        const SizedBox(height: 30,),
                        defaultButton(background: defaultColor,
                            text: 'Save change',
                            function: () {})
                      ],
                    ),
                  ),
                ),
              ),
          listener: (context, state) {}),);
  }
}
