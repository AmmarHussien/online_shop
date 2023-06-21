import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_shop/components/shared/check_out_button.dart';
import 'package:online_shop/components/style/app_style.dart';
import 'package:online_shop/controller/provider/product_provider.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/helper.dart';
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
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');

  late Future<Sneakers> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakerById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFemaleSneakerById(widget.id);
    } else if (widget.category == "Kids' Running") {
      _sneaker = Helper().getKidsSneakerById(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<Sneakers>(
        future: _sneaker,
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
                                        child: const Icon(
                                          AntDesign.hearto,
                                          color: Colors.grey,
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
                                                  backgroundColor: Colors.black,
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
                                                itemBuilder: (context, index) {
                                                  final sizes = productNotifier
                                                      .shoesSize[index];
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: ChoiceChip(
                                                      shadowColor: Colors.black,
                                                      backgroundColor:
                                                          Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        side: const BorderSide(
                                                          color: Colors.black,
                                                          width: 2,
                                                          style:
                                                              BorderStyle.solid,
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
                                                              : Colors.black38,
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
                                                          productNotifier.sizes
                                                              .remove(sizes[
                                                                  'size']);
                                                        } else {
                                                          productNotifier.sizes
                                                              .add(sizes[
                                                                  'size']);
                                                        }
                                                        productNotifier
                                                            .toggleCheck(index);
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
                                                _createCart({
                                                  'id': sneaker.id,
                                                  'name': sneaker.name,
                                                  'category': sneaker.category,
                                                  'sizes':
                                                      productNotifier.sizes,
                                                  'imageUrl':
                                                      sneaker.imageUrl[0],
                                                  'price': sneaker.price,
                                                  'qty': 1,
                                                });
                                                productNotifier.sizes.clear();
                                                Navigator.pop(context);
                                              },
                                              lable: 'Add to Bag',
                                            ),
                                          ),
                                        ),
                                      ],
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
