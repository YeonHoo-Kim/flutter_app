import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:ecommerce_app/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // screen moves to drag direction when scrolling
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.getHeight(70),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial);
                  },
                  child: const AppIcon(icon: Icons.clear),
                ),
                const AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.getHeight(20)),
                    topRight: Radius.circular(Dimensions.getHeight(20)),
                  ),
                ),
                child: const Center(
                  child: BigText(
                    size: 26,
                    text: "Korean side",
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food1.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.getWidth(20),
                    right: Dimensions.getWidth(20),
                  ),
                  child: const ExpandableText(
                    text:
                        "In recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.\nIn recent years South Korea has become better known for its technology than its food. However, thanks to delicacies like kimchi, which has become a global sensation, things are beginning to change. Here are is a list of South Korean foods you have to try.",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        // Column을 Container에 담아서 height에 대한 지정 없이 사용할 수 있게 함
        // MainAxisSize의 최소한을 사용
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.getWidth(50),
              right: Dimensions.getWidth(50),
              top: Dimensions.getHeight(10),
              bottom: Dimensions.getHeight(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppIcon(
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.remove,
                  iconSize: 24,
                ),
                BigText(
                  text: "\$12.88 X 0",
                  color: AppColors.mainBlackColor,
                  size: 26,
                ),
                AppIcon(
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  icon: Icons.add,
                  iconSize: 24,
                ),
              ],
            ),
          ),
          Container(
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
                    borderRadius:
                        BorderRadius.circular(Dimensions.getHeight(20)),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
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
                    borderRadius:
                        BorderRadius.circular(Dimensions.getHeight(20)),
                    color: AppColors.mainColor,
                  ),
                  child: const BigText(
                    text: "\$12.88 | Add to cart",
                    color: Colors.white,
                    size: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
