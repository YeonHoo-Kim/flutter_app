import 'package:flutter/material.dart';

import 'package:get/get.dart';

// import 'package:ecommerce_app/pages/food/popular_food_detail.dart';
import 'package:ecommerce_app/pages/food/recommended_food_detail.dart';
// import 'package:ecommerce_app/pages/home/main_food_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecommendedFoodDetail(),
    );
  }
}
