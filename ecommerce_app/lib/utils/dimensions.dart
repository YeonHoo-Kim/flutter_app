import 'package:get/get.dart';

class Dimensions {
  // set standard height, width
  static double height = 802.9;
  static double width = 392.7;

  // get current context height, width
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  static double statusBarHeight = Get.context!.mediaQueryViewPadding.top;

  // height
  static double height20 = screenHeight / (height / 20);

  // width
  static double width20 = screenWidth / (width / 20);

  static double getHeight(double h) {
    return screenHeight / (height / h);
  }

  static double getWidth(double w) {
    return screenWidth / (width / w);
  }
}
