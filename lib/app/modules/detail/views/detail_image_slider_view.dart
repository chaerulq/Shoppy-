import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/product_models.dart';

class DetailImageSliderView extends GetView {
  final Product product;
  const DetailImageSliderView({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    return Container(
      height: h - (h - 350),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(product.image),
        ),
      ),
    );
  }
}
