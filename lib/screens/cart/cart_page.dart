import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/components/shared/check_out_button.dart';
import 'package:online_shop/components/style/app_style.dart';
import 'package:online_shop/controller/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cartNotifier = Provider.of<CartNotifier>(context);
    cartNotifier.getCart();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(
          12,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'My Cart',
                  style: appstyle(
                    36,
                    Colors.black,
                    FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.65,
                  child: ListView.builder(
                    itemCount: cartNotifier.cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cartNotifier.cart[index];
                      return Padding(
                        padding: const EdgeInsets.all(
                          8,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              12,
                            ),
                          ),
                          child: Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 2,
                                  backgroundColor: const Color(0xFF000000),
                                  foregroundColor: Colors.white,
                                  icon: Icons.archive,
                                  label: 'Delete',
                                  onPressed: (BuildContext context) {
                                    cartNotifier.deleteCart(data['key']);
                                    setState(() {});
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => MainScreen(),
                                    //   ),
                                    // );
                                  },
                                ),
                              ],
                            ),
                            child: Container(
                              height: size.height * 0.11,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0.3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                          12,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: data['imageUrl'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                          left: 20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: appstyle(
                                                16,
                                                Colors.black,
                                                FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data['category'],
                                              style: appstyle(
                                                14,
                                                Colors.grey,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  data['price'],
                                                  style: appstyle(
                                                    18,
                                                    Colors.black,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                Text(
                                                  'Size',
                                                  style: appstyle(
                                                    18,
                                                    Colors.grey,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '${data['sizes']}',
                                                  style: appstyle(
                                                    18,
                                                    Colors.grey,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                16,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  AntDesign.minussquare,
                                                  size: 20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                data['qty'].toString(),
                                                style: appstyle(
                                                  12,
                                                  Colors.black,
                                                  FontWeight.w600,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  AntDesign.plussquare,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CheckOutButton(
                label: "Proceed to Checkout",
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
