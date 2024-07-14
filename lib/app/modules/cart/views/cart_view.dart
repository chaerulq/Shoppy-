import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/app/modules/cart/controllers/cart_controller.dart';
import 'package:shoppy/app/modules/cart/views/cart_card.dart';
import 'package:shoppy/app/modules/cart/views/cart_ceckout.dart';
import 'package:shoppy/app/utils/color.dart';

class CartView extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor2,
          title: Text(
            "Cart",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: cartController.itemCount,
            itemBuilder: (context, index) {
              final entry = cartController.cartItems.entries.elementAt(index);
              final product = entry.key;
              return CartCard(
                entry: entry,
                product: product,
              );
            },
          );
        }),
        bottomNavigationBar: CheckoutCard());
  }
}
