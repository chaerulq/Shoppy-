import 'package:firebase_database/firebase_database.dart';

import '../models/product_models.dart';

class FirebaseService {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  // Future<List<Item>> getItems() async {
  //   QuerySnapshot snapshot = await _db.collection('items').get();

  //   return snapshot.docs.map((doc) {
  //     return Item.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  //   }).toList();
  // }

  Future<List<Product>> fetchProducts() async {
    try {
      DataSnapshot snapshot = await _db.child('product').get();
      final List<Product> products = [];
      final data = snapshot.value as List<dynamic>;
      for (var value in data) {
        products.add(Product.fromMap(Map<String, dynamic>.from(value)));
      }
      return products;
    } catch (error) {
      rethrow;
    }
  }
}
