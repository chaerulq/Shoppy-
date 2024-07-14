import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shoppy/app/utils/color.dart';

class DetailAppbarView extends GetView {
  const DetailAppbarView({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: greyColor2,
            ),
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          const Spacer(),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: greyColor2,
            ),
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
          ),
          SizedBox(width: w - (w - 5)),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: greyColor2,
            ),
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
    );
  }
}
