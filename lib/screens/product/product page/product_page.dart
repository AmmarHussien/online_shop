import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_shop/components/shared/check_out_button.dart';
import 'package:online_shop/components/style/app_style.dart';
import 'package:online_shop/controller/provider/favorites_provider.dart';
import 'package:online_shop/controller/provider/product_provider.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/screens/cart/cart_page.dart';
import 'package:online_shop/screens/favorites/favorites_screen.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.id,
    required this.category,
  });

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final FavoritesNotifier favoritesNotifier = FavoritesNotifier();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getShoes(widget.category, widget.id);
    var favoritesNotifier = Provider.of<FavoritesNotifier>(
      context,
      listen: true,
    );
    favoritesNotifier.getFavorites();
    final cartBox = Hive.box('cart_box');
    Future<void> createCart(Map<dynamic, dynamic> newCart) async {
      await cartBox.add(newCart);
    }

    return Scaffold(
      body: FutureBuilder<Sneakers>(
        future: productNotifier.sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            final sneaker = snapshot.data;
            return Consumer<ProductNotifier>(
              builder: (context, productNotifier, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                productNotifier.shoesSize.clear();
                              },
                              child: const Icon(
                                AntDesign.close,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Ionicons.ellipsis_horizontal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: size.height * 0.5,
                              width: size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height: size.height * 0.39,
                                        width: size.width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top: size.height * 0.12,
                                        right: 20,
                                        child: Consumer<FavoritesNotifier>(
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (favoritesNotifier.ids
                                                    .contains(widget.id)) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Favorites(),
                                                    ),
                                                  );
                                                } else {
                                                  favoritesNotifier.createFav({
                                                    "id": sneaker.id,
                                                    "name": sneaker.name,
                                                    "category":
                                                        sneaker.category,
                                                    "price": sneaker.price,
                                                    "imageUrl":
                                                        sneaker.imageUrl[0],
                                                  });
                                                }
                                                setState(() {});
                                              },
                                              child: favoritesNotifier.ids
                                                      .contains(sneaker.id)
                                                  ? const Icon(AntDesign.heart)
                                                  : const Icon(
                                                      AntDesign.hearto),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height: size.height * 0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor: productNotifier
                                                            .activePage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 50,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: size.height * 0.645,
                                  width: size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      12,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneaker.name,
                                            style: appstyle(40, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appstyle(20, Colors.grey,
                                                    FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appstyle(
                                                  26,
                                                  Colors.black,
                                                  FontWeight.w600,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Colors',
                                                    style: appstyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Select Size',
                                                    style: appstyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    'View size guide',
                                                    style: appstyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                child: ListView.builder(
                                                  itemCount: productNotifier
                                                      .shoesSize.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final sizes =
                                                        productNotifier
                                                            .shoesSize[index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      child: ChoiceChip(
                                                        shadowColor:
                                                            Colors.black,
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(60),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.black,
                                                            width: 2,
                                                            style: BorderStyle
                                                                .solid,
                                                          ),
                                                        ),
                                                        disabledColor:
                                                            Colors.white,
                                                        label: Text(
                                                          productNotifier
                                                                  .shoesSize[
                                                              index]['size'],
                                                          style: appstyle(
                                                            18,
                                                            sizes['isSelected']
                                                                ? Colors.black
                                                                : Colors
                                                                    .black38,
                                                            FontWeight.w500,
                                                          ),
                                                        ),
                                                        selected:
                                                            sizes['isSelected'],
                                                        onSelected: (newState) {
                                                          if (productNotifier
                                                              .sizes
                                                              .contains(sizes[
                                                                  'size'])) {
                                                            productNotifier
                                                                .sizes
                                                                .remove(sizes[
                                                                    'size']);
                                                          } else {
                                                            productNotifier
                                                                .sizes
                                                                .add(sizes[
                                                                    'size']);
                                                          }
                                                          productNotifier
                                                              .toggleCheck(
                                                                  index);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.8,
                                            child: Text(
                                              sneaker.title,
                                              style: appstyle(
                                                23,
                                                Colors.black,
                                                FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            sneaker.description,
                                            textAlign: TextAlign.justify,
                                            maxLines: 4,
                                            style: appstyle(
                                              14,
                                              Colors.grey,
                                              FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 12,
                                              ),
                                              child: CheckOutButton(
                                                onTap: () async {
                                                  createCart({
                                                    'id': sneaker.id,
                                                    'name': sneaker.name,
                                                    'category':
                                                        sneaker.category,
                                                    'sizes': productNotifier
                                                        .sizes[0],
                                                    'imageUrl':
                                                        sneaker.imageUrl[0],
                                                    'price': sneaker.price,
                                                    'qty': 1,
                                                  });
                                                  productNotifier.sizes.clear();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CartPage(),
                                                    ),
                                                  );
                                                },
                                                label: 'Add to Bag',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
