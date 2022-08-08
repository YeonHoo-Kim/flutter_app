import 'package:ecommerce_app/pages/food/popular_food_detail.dart';
import 'package:ecommerce_app/pages/food/recommended_food_detail.dart';
import 'package:ecommerce_app/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String _initial = "/";
  static const String _popularFood = "/popular-food";
  static const String _recommendedFood = "/recommended-food";

  static String get getInitial => _initial;
  static String get getPopularFood => _popularFood;
  static String get getRecommendedFood => _recommendedFood;

  // 아래와 같은 방식으로 param을 받아서 조건부 라우팅을 할 수있음
  static String getPopularFoodPage(int pageId) =>
      '$_popularFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: _initial, page: () => const MainFoodPage()),
    GetPage(
      name: _popularFood,
      page: () {
        String pageId = Get.parameters['pageId']!;
        return PopularFoodDetail(pageId: int.parse(pageId));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(name: _recommendedFood, page: () => const RecommendedFoodDetail()),
  ];
}
