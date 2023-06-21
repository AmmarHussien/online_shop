import 'package:flutter/material.dart';
import 'package:online_shop/components/style/app_style.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    super.key,
    this.onTap,
    required this.label,
  });
  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 50,
          width: size.width * 0.9,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(
                12,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: appstyle(
                20,
                Colors.white,
                FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
