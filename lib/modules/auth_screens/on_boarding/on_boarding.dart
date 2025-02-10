import 'package:farm_hub/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../shared/components/components.dart';
import '../login/login.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultButton(
                    text: 'Get start',
                    function: () {
                      CacheHelper.saveData(key: 'onboarded', value: true);
                      navigateAndFinish(context, const LoginScreen());
                    },
                    radius: 100,
                    height: 58,
                    background: HexColor('#30935F')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
