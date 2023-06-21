import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/controller/provider/product_provider.dart';
import 'package:online_shop/screens/home/components/new_shoes.dart';
import 'package:online_shop/components/shared/product_card.dart';
import 'package:online_shop/components/style/app_style.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/screens/product/product%20by%20category/product_by_category.dart';
import 'package:online_shop/screens/product/product%20page/product_page.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> gender,
    required this.tabIndex,
  }) : _gender = gender;

  final Future<List<Sneakers>> _gender;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.405,
          child: FutureBuilder<List<Sneakers>>(
            future: _gender,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              } else {
                final gender = snapshot.data;

                return ListView.builder(
                  itemCount: gender!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        productNotifier.shoesSize = shoe.sizes;
                      
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              id: shoe.id,
                              category: shoe.category,
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        price: '\$ ${shoe.price}',
                        categoy: shoe.category,
                        id: shoe.id,
                        name: shoe.name,
                        image: shoe.imageUrl[0],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                20,
                12,
                20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Shoes',
                    style: appstyle(
                      24,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductByCategory(
                            tabIndex: tabIndex,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Show All',
                          style: appstyle(
                            22,
                            Colors.black,
                            FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          AntDesign.caretright,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.13,
          child: FutureBuilder<List<Sneakers>>(
            future: _gender,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              } else {
                final gender = snapshot.data;

                return ListView.builder(
                  itemCount: gender!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final shoe = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewShoes(
                        image: shoe.imageUrl[1],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
