import 'package:flutter/material.dart';
import 'package:online_shop/components/style/app_style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'search page',
          style: appstyle(
            40,
            Colors.green,
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
