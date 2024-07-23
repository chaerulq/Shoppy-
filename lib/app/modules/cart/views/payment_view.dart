import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/app/modules/cart/views/pincode_widget.dart';
import 'package:shoppy/app/utils/fancy_button.dart';

import '../../../utils/color.dart';
import '../../../utils/result_state.dart';
import '../controllers/cart_controller.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymentController controller = Get.put(PaymentController());
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(cartController.totalPrice);
    return Obx(() {
      if (controller.isPin.isTrue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showPinVerificationSheet();
        });
      } else if (controller.state == ResultState.paymentSuccesful) {
        controller.clearCall();
        Get.back();
        print("succes");
      } else if (controller.state == ResultState.balanceIsLow) {
        controller.clearCall();
        Get.back();

        print("saldo kurang");
      } else if (controller.state == ResultState.wrongPin) {
        controller.clearCall();
        print("salah pin");
        Get.back();
      }
      return controller.isLoading.value
          ? Stack(
              children: [
                PaymentWid(
                    formattedPrice: formattedPrice, controller: controller),
                const Opacity(
                  opacity: 0.3,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
                Center(child: Lottie.asset('assets/lottie/11.json'))
              ],
            )
          : PaymentWid(formattedPrice: formattedPrice, controller: controller);
    });
  }

  // PIN showModalBottomSheet
  void _showPinVerificationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ensure modal adjusts to content height
      builder: (context) {
        return Wrap(
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: PinCodeWidget(
                  onPinEntered: (enteredPin) {
                    controller.verifyPIN(enteredPin);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PaymentWid extends StatelessWidget {
  const PaymentWid({
    super.key,
    required this.formattedPrice,
    required this.controller,
  });

  final String formattedPrice;
  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: greenColor2,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        color: greyColor2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Total Pembayaran",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          text: "Rp ",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: 25,
                              color: greenColor1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            TextSpan(
                              text: formattedPrice,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 36,
                                  color: greenColor1,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: greyColor3,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Metode Pembayaran",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.qr_code_scanner_outlined,
                            color: greenColor2,
                          ),
                          Text(
                            "Shoppy Card",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: double.infinity,
            child: FancyButton(
              text: "Konfirmasi",
              onPressed: () {
                controller.startLoading();
              },
              color: greenColor2,
              borderRadius: 0,
            ),
          ),
        ),
      ),
    );
  }
}
