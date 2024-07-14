import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoppy/app/modules/cart/views/payment_view.dart';
import 'package:shoppy/app/utils/color.dart';
import 'package:shoppy/app/utils/fancy_button.dart';

import '../controllers/cart_controller.dart';

class CheckoutCard extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CheckoutCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final formattedPrice =
          NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
              .format(cartController.totalPrice);
      return Container(
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text.rich(
                        TextSpan(
                          text: "Total: ",
                          children: [
                            TextSpan(
                              text: "Rp",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 14,
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: FancyButton(
                    text: "Checkout",
                    onPressed: () {
                      Get.to(() => PaymentView());
                      cartController.checkout();
                    },
                    color: greenColor2,
                    borderRadius: 0,
                  )),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
