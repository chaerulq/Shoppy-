import 'package:get/get.dart';
import '../../../data/models/product_models.dart';

class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs;

  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
  }

  void removeFromCart(Product product) {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
    } else {
      cartItems.remove(product);
    }
  }

  void decreaseQuantity(Product product) {
    if (cartItems[product]! > 1) {
      cartItems[product] = (cartItems[product] ?? 0) - 1;
    } else {
      cartItems.remove(product);
    }
  }

  void increaseQuantity(Product product) {
    cartItems[product] = (cartItems[product] ?? 0) + 1;
  }

  void removeSelectedItem(Product product) {
    cartItems.remove(product);
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
