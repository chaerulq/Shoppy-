import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shoppy/app/data/models/product_models.dart';
import 'package:shoppy/app/modules/detail/views/detail_description_view.dart';
import 'package:shoppy/app/modules/detail/views/detail_image_slider_view.dart';
import 'package:shoppy/app/utils/color.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: greenColor2,
        child: const Icon(
          Icons.add_shopping_cart_sharp,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                DetailImageSliderView(
                  product: product,
                ),
                // SafeArea(child: DetailAppbarView()),
              ],
            ),
            DetailDescriptionView(product: product)
          ],
        ),
      ),
    );
  }
}
