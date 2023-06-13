import 'package:flutter/material.dart';

import 'package:online_shop/controller/provider/main_screen_provider.dart';
import 'package:online_shop/screens/cart/cart_screen.dart';
import 'package:online_shop/screens/profile/profile_screen.dart';
import 'package:online_shop/screens/search/search_screen.dart';
import 'package:provider/provider.dart';

import '../../components/shared/bottom_nav_bar.dart';
import '../home/home_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = const [
    HomePage(),
    SearchScreen(),
    HomePage(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (
        BuildContext context,
        MainScreenNotifier mainScreenNotifier,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
