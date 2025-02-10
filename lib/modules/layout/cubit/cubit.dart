import 'package:farm_hub/modules/layout/cubit/state.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../add_product/add_product.dart';
import '../../home/home.dart';
import '../../chat/inbox.dart';
import '../../profile/profile_screen.dart';
import '../../search.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    AddProductScreen(),
    InboxScreen(),
    ProfileScreen()
  ];

  List<BottomNavigationBarItem> bottomNav = [
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search_circle), label: 'Search'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.add_circled), label: 'Add Product'),
    const BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.inbox), label: 'Inbox'),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
  ];

  int currentIndex = 0;

  void changeBar(index) {
    currentIndex = index;
    emit(AppChangeBarState());
  }

  bool isPassword = true;
  bool isConfirmPassword = true;
  IconData suffix = FluentIcons.eye_off_24_filled;
  IconData suffixConfirm = FluentIcons.eye_off_24_filled;
  void changePass() {
    isPassword = !isPassword;
    if (isPassword == true) {
      suffix = FluentIcons.eye_off_24_filled;
    } else {
      suffix = FluentIcons.eye_24_filled;
    }
    emit(SocialChangeVisible());
  }

  void changeConfirmPass() {
    isConfirmPassword = !isConfirmPassword;
    if (isConfirmPassword == true) {
      suffixConfirm = FluentIcons.eye_off_24_filled;
    } else {
      suffixConfirm = FluentIcons.eye_24_filled;
    }
    emit(SocialChangeVisible());
  }
}
