import 'package:get/get.dart';
import '../../../data/models/product_models.dart';

class FavoriteController extends GetxController {
  var favoriteItems = <Product>[].obs;

  void addToFavorites(Product product) {
    if (!favoriteItems.contains(product)) {
      favoriteItems.add(product);
    }
  }

  void removeFromFavorites(Product product) {
    favoriteItems.remove(product);
  }

  bool isFavorite(Product product) {
    return favoriteItems.contains(product);
  }
}
