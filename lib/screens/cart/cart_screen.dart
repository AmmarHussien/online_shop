import 'package:flutter/material.dart';
import 'package:online_shop/components/style/app_style.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'cart page',
          style: appstyle(
            40,
            Colors.yellow,
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
