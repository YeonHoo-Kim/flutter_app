import 'package:ecommerce_app/controllers/popular_product_controller.dart';
import 'package:ecommerce_app/pages/home/main_food_page.dart';
import 'package:ecommerce_app/routes/route_helper.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/app_column.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:ecommerce_app/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.getHeight(350),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/image/food1.png",
                  ),
                ),
              ),
            ),
          ),
          // icon widgets in header (back, cart)
          Positioned(
            top: Dimensions.getHeight(45),
            left: Dimensions.getWidth(20),
            right: Dimensions.getWidth(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial);
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                const AppIcon(icon: Icons.shopping_cart_checkout_outlined),
              ],
            ),
          ),
          // introduction of food
          Positioned(
            top: Dimensions.getHeight(350 - 20),
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.getHeight(20),
                left: Dimensions.getWidth(20),
                right: Dimensions.getWidth(20),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.getHeight(20)),
                  topRight: Radius.circular(Dimensions.getHeight(20)),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppColumn(text: "Korean Foods"),
                  SizedBox(height: Dimensions.getHeight(20)),
                  const BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.getHeight(10)),
                  const Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(
                        text:
                            "In recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.In recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.getHeight(130),
        padding: EdgeInsets.only(
          top: Dimensions.getHeight(30),
          bottom: Dimensions.getHeight(30),
          left: Dimensions.getWidth(20),
          right: Dimensions.getWidth(20),
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.getHeight(20) * 2),
            topRight: Radius.circular(Dimensions.getHeight(20) * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.getHeight(20),
                bottom: Dimensions.getHeight(20),
                left: Dimensions.getWidth(20),
                right: Dimensions.getWidth(20),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(width: Dimensions.getWidth(5)),
                  const BigText(text: "0"),
                  SizedBox(width: Dimensions.getWidth(5)),
                  const Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: Dimensions.getHeight(20),
                bottom: Dimensions.getHeight(20),
                left: Dimensions.getWidth(20),
                right: Dimensions.getWidth(20),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                color: AppColors.mainColor,
              ),
              child: const BigText(
                text: "\$10 | Add to cart",
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
