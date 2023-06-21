import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewShoes extends StatelessWidget {
  const NewShoes({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 1,
            blurRadius: 0.8,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      height: size.height * 0.12,
      width: size.width * 0.28,
      child: CachedNetworkImage(
        imageUrl: image,
      ),
    );
  }
}
