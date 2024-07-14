import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/home/controllers/home_controller.dart';

import '../../../data/models/category_model.dart';
import '../../../utils/color.dart';

class HomeCategoryView extends GetView {
  const HomeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: height - (height - 95),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.selectedCategory.value = categories[index].id;
            },
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: height - (height - 60),
                      width: width - (width - 60),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greenColor3,
                      ),
                    ),
                    Container(
                      height: height - (height - 40),
                      width: width - (width - 40),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(categories[index].image),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height - (height - 5)),
                Text(
                  categories[index].title,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 11,
                      color: ktextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
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
