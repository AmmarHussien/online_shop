import 'package:flutter/material.dart';
import 'package:online_shop/components/style/app_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home page',
          style: appstyle(
            40,
            Colors.amber,
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
