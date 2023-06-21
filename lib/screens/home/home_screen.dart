import 'package:flutter/material.dart';

import 'package:online_shop/components/style/app_style.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/helper.dart';

import 'components/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
    getMale();
    getFemale();
    getKids();
    super.initState();
  }

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
              child: Container(
                padding: const EdgeInsets.only(
                  left: 8,
                  bottom: 15,
                ),
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Athletics Shoes',
                      style: appstyleWithHeight(
                        42,
                        Colors.white,
                        FontWeight.bold,
                        1.5,
                      ),
                    ),
                    Text(
                      'Collection',
                      style: appstyleWithHeight(
                        42,
                        Colors.white,
                        FontWeight.bold,
                        1.5,
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
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.265,
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 12,
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(
                      gender: _male,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      gender: _female,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      gender: _kids,
                      tabIndex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
