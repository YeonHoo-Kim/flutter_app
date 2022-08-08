import 'package:ecommerce_app/data/repository/popular_product_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/products.dart';

class PopularProductController extends GetxController {
  // Controller의 역할
  // 생성자를 통해 Repository를 불러와서 사용
  // Repository에서 사용하기 좋게 바꿔둔 data를 이용함
  // 1. 모든 Controller에는 하나의 Repository가 있어야 하며, 초기화에 필요
  // 2. 각 page에 대해 하나 이상의 Controller를 사용하는 것이 좋음
  // 3. 모든 페이지가 단일 데이터를 사용할 경우, 같은 Controller로 여러 페이지 사용 가능
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  // if there's a underscore(_) for a variable it means private
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _loaded = false;
  bool get loaded => _loaded;

  Future<void> getPopularProductList() async {
    // debugPrint('getPopularProductList');
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      // debugPrint('got products');
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // debugPrint(_popularProductList.toString());
      _loaded = true;
      update(); // ui update (same as setState)
    } else {}
  }
}
