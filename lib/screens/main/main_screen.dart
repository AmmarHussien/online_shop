import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:online_shop/components/shared/bottom_nav_widget.dart';
import 'package:online_shop/screens/cart/cart_screen.dart';
import 'package:online_shop/screens/profile/profile_screen.dart';
import 'package:online_shop/screens/search/search_screen.dart';

import '../home/home_screen.dart';

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
    int pageIndex = 4;

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: pageList[pageIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BotomNavWidget(
                  onTap: () {},
                  icon: CommunityMaterialIcons.home,
                ),
                BotomNavWidget(
                  onTap: () {},
                  icon: Ionicons.search,
                ),
                BotomNavWidget(
                  onTap: () {},
                  icon: Ionicons.add,
                ),
                BotomNavWidget(
                  onTap: () {},
                  icon: Ionicons.cart,
                ),
                BotomNavWidget(
                  onTap: () {},
                  icon: Ionicons.person,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
