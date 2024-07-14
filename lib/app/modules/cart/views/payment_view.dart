import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends StatelessWidget {
  PaymentController controller = Get.put(PaymentController());

  PaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: Center(
        child: controller.isLoading.value
            ? const CircularProgressIndicator()
            : Text(
                controller.statusMessage.value,
              ),
      ),
    );
  }
}
