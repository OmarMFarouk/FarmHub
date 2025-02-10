
import 'package:farm_hub/shared/components/components.dart';
import 'package:flutter/material.dart';

class InterestScreen extends StatelessWidget {
  const InterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: back(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Interests',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
