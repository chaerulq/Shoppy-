import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import pustaka intl
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/data/models/product_models.dart';
import 'package:shoppy/app/modules/cart/controllers/cart_controller.dart';
import 'package:shoppy/app/routes/app_pages.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../utils/color.dart';
import '../../favorite/controllers/favorite_controller.dart';

class CardProductView extends GetView {
  final CartController cartController = Get.find<CartController>();
  final FavoriteController favoritesController = Get.find<FavoriteController>();

  final Product product;
  CardProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    String value = product.price;
    double doublevalue = double.parse(value);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final formattedPrice =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
            .format(doublevalue);
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.detail, arguments: product);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: height - (height - 110),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: height - (height - 30),
                    width: width - (width - 30),
                    decoration: BoxDecoration(
                      color: greenColor2,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (favoritesController.isFavorite(product)) {
                          favoritesController.removeFromFavorites(product);
                        } else {
                          favoritesController.addToFavorites(product);
                        }
                      },
                      child: Obx(() {
                        return Icon(
                          favoritesController.isFavorite(product)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Rp",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: greenColor1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      children: [
                        TextSpan(
                          text: formattedPrice,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: greenColor1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: ktextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: height - (height - 10)),
                  ZoomTapAnimation(
                    onTap: () => cartController.addToCart(product),
                    child: Container(
                      height: height - (height - 30),
                      width: width - (width - 135),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Colors.white,
                            size: 17,
                          ),
                          SizedBox(width: width - (width - 5)),
                          Text(
                            "ADD TO CART",
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
