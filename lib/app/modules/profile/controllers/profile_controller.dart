import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/product_models.dart';

class ProfileController extends GetxController {
  var cartItems = <Product, int>{}.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    var storedCart = box.read<Map<String, dynamic>>('cart');
    if (storedCart != null) {
      cartItems.assignAll(storedCart.map((key, value) {
        var productMap = Map<String, dynamic>.from(json.decode(key));
        return MapEntry(Product.fromMap(productMap), value as int);
      }));
    }
  }

  void saveCart() {
    var cartMap = cartItems
        .map((key, value) => MapEntry(json.encode(key.toMap()), value));
    box.write('cart', cartMap);
  }

  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    saveCart();
  }

  void removeFromCart(Product product) {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
    } else {
      cartItems.remove(product);
    }
    saveCart();
  }

  int get itemCount => cartItems.length;

  double get totalPrice => cartItems.entries.fold(0, (sum, item) {
        return sum + double.parse(item.key.price) * item.value;
      });
  // Method untuk melakukan proses checkout
  void checkout() {
    // Lakukan proses pembayaran, pengiriman, dll. di sini
    // Setelah proses selesai, reset keranjang belanja
    cartItems.clear();
  }
}
