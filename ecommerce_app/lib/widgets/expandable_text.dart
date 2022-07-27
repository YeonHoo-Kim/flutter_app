import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hidden = true;

  double textHeight = Dimensions.getHeight(150);

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt(), widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              height: 1.8,
              color: AppColors.paraColor,
              text: firstHalf,
              size: 16)
          : Column(
              children: [
                SmallText(
                  height: 1.8,
                  color: AppColors.paraColor,
                  text: hidden ? "$firstHalf..." : "$firstHalf$secondHalf",
                  size: 16,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                  child: Row(
                    children: [
                      const SmallText(
                        text: "Show more",
                        color: AppColors.mainColor,
                        size: 16,
                      ),
                      Icon(hidden ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                          color: AppColors.mainColor),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
