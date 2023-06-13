import 'package:flutter/material.dart';
import 'package:online_shop/components/style/app_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'profile page',
          style: appstyle(
            40,
            Colors.red,
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
