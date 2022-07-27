import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/widgets/app_column.dart';
import 'package:ecommerce_app/widgets/big_text.dart';
import 'package:ecommerce_app/widgets/icon_and_text_widget.dart';
import 'package:ecommerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class BodyFoodPage extends StatefulWidget {
  const BodyFoodPage({Key? key}) : super(key: key);

  @override
  State<BodyFoodPage> createState() => _BodyFoodPageState();
}

class _BodyFoodPageState extends State<BodyFoodPage> {
  PageController pageController = PageController(
    viewportFraction: 0.85, // 슬라이더 한 페이지가 차지하는 화면의 비율
  );
  double currentPageValue = 0.0; // 슬라이딩 하는 페이지 값 (천천히도 가능)
  double scaleFactor = 0.8; //
  double height = Dimensions.getHeight(220); // slider height

  @override
  void initState() {
    // 페이지 진입 시 state 초기화
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // 페이지 퇴장 시 state dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider section
        Container(
          // color: Colors.blueAccent,
          height: Dimensions.getHeight(320),
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        // dots section
        DotsIndicator(
          dotsCount: 5,
          position: currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        // popular section
        SizedBox(height: Dimensions.getHeight(30)),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.getWidth(30),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BigText(text: "Popular"),
              SizedBox(width: Dimensions.getWidth(10)),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: const BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Dimensions.getWidth(10)),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: const SmallText(
                    text: "Food pairing", color: Colors.black26),
              ),
            ],
          ),
        ),
        // list of food and images
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true, // height 없이도 scroll 가능하도록 화면에 맞춤
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: Dimensions.getWidth(20),
                  right: Dimensions.getWidth(20),
                  bottom: Dimensions.getHeight(10),
                ),
                child: Row(
                  children: [
                    // image section
                    Container(
                      width: Dimensions.getHeight(120),
                      height: Dimensions.getHeight(120),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.getHeight(20)),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/image/food${index + 1}.png",
                            ),
                          )),
                    ),
                    // text container
                    Expanded(
                      child: Container(
                        height: Dimensions.getHeight(100),
                        padding: EdgeInsets.only(
                          left: Dimensions.getWidth(5),
                          right: Dimensions.getWidth(5),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.getHeight(20)),
                            bottomRight:
                                Radius.circular(Dimensions.getHeight(20)),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.getWidth(10),
                            right: Dimensions.getWidth(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const BigText(text: "Delicious foods in korea"),
                              SizedBox(height: Dimensions.getHeight(10)),
                              const SmallText(text: "This is a content"),
                              SizedBox(height: Dimensions.getHeight(10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  IconAndTextWidget(
                                    icon: Icons.circle_sharp,
                                    text: "Normal",
                                    iconColor: AppColors.iconColor1,
                                  ),
                                  IconAndTextWidget(
                                    icon: Icons.location_on,
                                    text: "1.7km",
                                    iconColor: AppColors.mainColor,
                                  ),
                                  IconAndTextWidget(
                                    icon: Icons.access_time_rounded,
                                    text: "32min",
                                    iconColor: AppColors.iconColor2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity(); // 슬라이드 이동 시 페이지의 위치 정보 값
    double currScale = 0.8; // scaleY of matrix
    double currTrans = height / 10; //
    if (index == currentPageValue.floor() + 1) {
      // right(next) slide
      currScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
    } else if (index == currentPageValue.floor() + 2) {
      // right right(3rd) slide
      // 3rd slide should be default value...
    } else {
      // current & left(prev) slide,
      currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
    }
    currTrans = height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.getHeight(220),
            margin: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.getHeight(30)),
              // color: index.isEven
              //     ? const Color(0xFF69c5df)
              //     : const Color(0xFF9294cc),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/image/food1.png",
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.getHeight(120),
              margin: EdgeInsets.only(
                left: Dimensions.getWidth(30),
                right: Dimensions.getWidth(30),
                bottom: Dimensions.getHeight(30),
              ),
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.black,
                //   width: 1,
                // ),
                borderRadius: BorderRadius.circular(Dimensions.getHeight(20)),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.getHeight(15),
                  left: 15,
                  right: 15,
                ),
                child: const AppColumn(text: "Korean Foods"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
