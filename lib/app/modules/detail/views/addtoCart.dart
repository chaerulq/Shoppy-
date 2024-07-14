import 'package:flutter/material.dart';
import 'package:shoppy/app/data/models/product_models.dart';
import 'package:shoppy/app/utils/color.dart';

class AddToCart extends StatefulWidget {
  Product product;
  AddToCart({super.key, required this.product});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.black),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: 18,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    currentIndex.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    iconSize: 18,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: greenColor2,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
