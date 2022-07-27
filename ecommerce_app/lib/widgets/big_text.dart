import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;

  const BigText({
    Key? key,
    this.color = AppColors.mainBlackColor,
    required this.text,
    this.size = 20,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        color: color,
        fontSize: Dimensions.getHeight(size),
      ),
    );
  }
}
