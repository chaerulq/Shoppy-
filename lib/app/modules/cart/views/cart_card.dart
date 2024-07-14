import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoppy/app/data/models/product_models.dart';
import 'package:shoppy/app/utils/color.dart';

import '../controllers/cart_controller.dart';

class CartCard extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  final dynamic entry;
  CartCard({
    super.key,
    required this.product,
    required this.entry,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
        NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
            .format(double.parse(product.price));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: ktextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    text: "Rp",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: greenColor1,
                        fontSize: 14),
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    IntrinsicWidth(
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: greyColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              iconSize: 15,
                              onPressed: () {
                                if (entry.value > 1) {
                                  cartController.decreaseQuantity(product);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              '${entry.value}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              iconSize: 15,
                              onPressed: () {
                                cartController.increaseQuantity(product);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartController.removeSelectedItem(product);
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: greenColor1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
