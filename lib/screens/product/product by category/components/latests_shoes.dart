import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/screens/product/product%20by%20category/components/stagger_tile.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> gender,
  }) : _gender = gender;

  final Future<List<Sneakers>> _gender;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Sneakers>>(
      future: _gender,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        } else {
          final gender = snapshot.data;

          return StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            itemCount: gender!.length,
            scrollDirection: Axis.vertical,
            staggeredTileBuilder: (index) => StaggeredTile.extent(
                (index % 2 == 0) ? 1 : 1,
                (index % 2 == 1 || index % 4 == 3)
                    ? size.height * 0.35
                    : size.height * 0.3),
            itemBuilder: (context, index) {
              final shoe = snapshot.data![index];
              return StaggerTile(
                imageUrl: shoe.imageUrl[1],
                name: shoe.name,
                price: '\$${shoe.price}',
              );
            },
          );
        }
      },
    );
  }
}
