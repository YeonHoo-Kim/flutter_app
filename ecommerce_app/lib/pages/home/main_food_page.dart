import 'package:ecommerce_app/pages/home/body_food_page.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            // showing the header(search)
            margin: EdgeInsets.only(
                top: Dimensions.statusBarHeight + Dimensions.getHeight(15),
                bottom: Dimensions.getHeight(15)),
            padding: EdgeInsets.only(
                left: Dimensions.getWidth(20), right: Dimensions.getWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const BigText(
                      text: "Korea",
                      color: AppColors.mainColor,
                      size: 30,
                    ),
                    Row(
                      children: const [
                        SmallText(
                          text: "Seoul",
                          color: Colors.black54,
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.getHeight(45),
                    height: Dimensions.getHeight(45),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.getHeight(15)),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.getHeight(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: BodyFoodPage(),
            ),
          ), // showing the body
        ],
      ),
    );
  }
}
