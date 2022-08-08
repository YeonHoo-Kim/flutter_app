import 'package:ecommerce_app/data/api/api_client.dart';
import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  // Repository의 역할
  // Entity의 분리 - 일반적으로 DB 테이블 모델 그대로 가져와 사용하는 것은 좋지 않음
  // Controller와 Data 사이 연결
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
