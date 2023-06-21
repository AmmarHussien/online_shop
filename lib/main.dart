import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_shop/controller/provider/cart_provider.dart';
import 'package:online_shop/controller/provider/favorites_provider.dart';
import 'package:online_shop/controller/provider/main_screen_provider.dart';
import 'package:online_shop/controller/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'screens/main/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainScreenNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesNotifier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
