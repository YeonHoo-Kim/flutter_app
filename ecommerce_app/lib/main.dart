import 'package:ecommerce_app/controllers/popular_product_controller.dart';
import 'package:ecommerce_app/controllers/recommended_product_controller.dart';
import 'package:ecommerce_app/routes/route_helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// import 'package:ecommerce_app/pages/food/popular_food_detail.dart';
// import 'package:ecommerce_app/pages/food/recommended_food_detail.dart';
import 'package:ecommerce_app/pages/home/main_food_page.dart';

import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  // ensure the initialization of dep.init()
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      home: const MainFoodPage(),
      initialRoute: RouteHelper.getInitial,
      getPages: RouteHelper.routes,
    );
  }
}
