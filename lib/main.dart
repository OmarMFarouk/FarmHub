import 'package:farm_hub/logic/chat/chat_cubit.dart';
import 'package:farm_hub/logic/posts/post_cubit.dart';
import 'package:farm_hub/logic/user/user_cubit.dart';
import 'package:farm_hub/modules/auth_screens/login/login.dart';
import 'package:farm_hub/modules/auth_screens/splash/splash_screen.dart';
import 'package:farm_hub/modules/auth_screens/on_boarding/on_boarding.dart';
import 'package:farm_hub/shared/bloc_observ.dart';
import 'package:farm_hub/shared/network/local/cache_helper.dart';
import 'package:farm_hub/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(ErrorWidgetClass(details));
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => PostCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        home: appRouter(),
      ),
    );
  }
}

Widget appRouter() {
  if (CacheHelper.getData(key: 'active')) {
    return const SplashScreen();
  }
  if (CacheHelper.getData(key: 'onboarded') &&
      CacheHelper.getData(key: 'active') == false) {
    return const LoginScreen();
  } else {
    return const OnBoarding();
  }
}

class ErrorWidgetClass extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const ErrorWidgetClass(this.errorDetails, {super.key});
  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      errorMessage: errorDetails.exceptionAsString(),
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50.0,
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Error Occurred!',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
