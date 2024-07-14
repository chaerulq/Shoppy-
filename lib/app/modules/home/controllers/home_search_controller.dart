import 'package:get/get.dart';
import 'package:shoppy/app/modules/home/controllers/home_controller.dart';
import '../../../data/models/product_models.dart';

class HomeSearchController extends GetxController {
  var products = <Product>[].obs; // Daftar semua produk
  var filteredProducts = <Product>[].obs; // Daftar produk yang difilter

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi daftar produk di sini
    fetchProducts();
  }

  void fetchProducts() {
    // Ganti dengan logika fetch data yang benar
    final homeController = Get.find<HomeController>();
    products.value = homeController.productList;
    filteredProducts.clear(); // Pastikan filteredProducts kosong pada awalnya
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.clear(); // Kosongkan filteredProducts jika query kosong
    } else {
      filteredProducts.value = products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  List<Product> get popularSearches {
    return products.where((product) => product.category == 'snack').toList();
  }

  void clearFilteredProducts() {
    filteredProducts.clear();
  }
}
