import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/app/data/models/product_models.dart';
import 'package:shoppy/app/modules/home/views/card_product_view.dart';
import 'package:shoppy/app/utils/color.dart';

class MyResultSearch extends StatelessWidget {
  const MyResultSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> filteredProducts = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product"),
          leading: PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }
              Get.back(result: 'success');
            },
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: greenColor2,
              ),
              onPressed: () {
                // Kembali ke halaman sebelumnya dengan menyertakan hasil
                Get.back(result: 'success');
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Obx(() {
            if (filteredProducts.isEmpty) {
              return const Center(
                child: Text('No products found'),
              );
            }
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1 / 1.3),
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return CardProductView(
                  product: product,
                );
              },
            );
          }),
        ));
  }
}
