import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:online_shop/screens/product/product%20by%20category/components/category_btn.dart';
import 'package:online_shop/screens/product/product%20by%20category/components/custom_spacer.dart';
import 'package:online_shop/components/style/app_style.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/helper.dart';

import 'components/latests_shoes.dart';

class ProductByCategory extends StatefulWidget {
  const ProductByCategory({
    super.key,
    required this.tabIndex,
  });

  final int tabIndex;

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory>
    with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneaker();
  }

  void getFemale() {
    _female = Helper().getFemaleSneaker();
  }

  void getKids() {
    _kids = Helper().getKidsSneaker();
  }

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
    getMale();
    getFemale();
    getKids();
  }

  List<String> brand = [
    'assets/images/adidas.png',
    'assets/images/nike.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(
                16,
                45,
                0,
                0,
              ),
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/top_image.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      6,
                      12,
                      16,
                      18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filer();
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.red,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appstyle(
                      24,
                      Colors.white,
                      FontWeight.bold,
                    ),
                    unselectedLabelColor: Colors.grey.withOpacity(
                      0.3,
                    ),
                    tabs: const [
                      Tab(
                        text: 'Men Shoes',
                      ),
                      Tab(
                        text: 'Women Shoes',
                      ),
                      Tab(
                        text: 'kids Shoes',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.175,
                left: 16,
                right: 12,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    16,
                  ),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LatestShoes(gender: _male),
                    LatestShoes(gender: _female),
                    LatestShoes(gender: _kids),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final double _value = 100;
  Future<dynamic> filer() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.83,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              25,
            ),
            topRight: Radius.circular(
              25,
            ),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 5,
              width: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  const CustomSpacer(),
                  Text(
                    'Filter',
                    style: appstyle(
                      40,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  const CustomSpacer(),
                  Text(
                    'Gender',
                    style: appstyle(
                      20,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      CategoryBtn(
                        buttonClr: Colors.black,
                        label: 'Male',
                      ),
                      CategoryBtn(
                        buttonClr: Colors.grey,
                        label: 'Female',
                      ),
                      CategoryBtn(
                        buttonClr: Colors.grey,
                        label: 'Kids',
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'Category',
                    style: appstyle(
                      20,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      CategoryBtn(
                        buttonClr: Colors.black,
                        label: 'Shoes',
                      ),
                      CategoryBtn(
                        buttonClr: Colors.grey,
                        label: 'Apparrels',
                      ),
                      CategoryBtn(
                        buttonClr: Colors.grey,
                        label: 'Accessories',
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'Price',
                    style: appstyle(
                      20,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  const CustomSpacer(),
                  Slider(
                    value: _value,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.black,
                    max: 500,
                    divisions: 50,
                    label: _value.toString(),
                    secondaryTrackValue: 200,
                    secondaryActiveColor: Colors.red,
                    onChanged: (double value) {},
                  ),
                  const CustomSpacer(),
                  Text(
                    'Brand',
                    style: appstyle(
                      20,
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 80,
                    child: ListView.builder(
                      itemCount: brand.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                            ),
                            child: Image.asset(
                              brand[index],
                              height: 60,
                              width: 80,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
