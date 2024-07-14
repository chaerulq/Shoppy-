import 'package:get/get.dart';
import 'package:shoppy/app/data/service/firebase_service.dart';

import '../../../data/models/product_models.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var selectedCategory = 'hot_deals'.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var products = await FirebaseService().fetchProducts();
      if (products.isNotEmpty) {
        productList.assignAll(products);
      }
    } finally {
      isLoading(false);
    }
  }

  List<String> get categories {
    return ['hot_deals', ...productList.map((p) => p.category).toSet()];
  }

  List<Product> get filteredProducts {
    if (selectedCategory.value == 'hot_deals') {
      return productList
          .where((product) => product.category == selectedCategory.value)
          .toList();
    } else {
      return productList
          .where((product) => product.category == selectedCategory.value)
          .toList();
    }
  }
}
