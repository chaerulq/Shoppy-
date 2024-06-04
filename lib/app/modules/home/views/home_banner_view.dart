import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/color.dart';

class HomeBannerView extends GetView {
  const HomeBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: height - (height - 120),
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: height - (height - 120),
            width: width - (width - 250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: greyColor,
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: width - (width - 15),
        ),
      ),
    );
  }
}
