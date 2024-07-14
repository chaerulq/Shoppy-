class Product {
  final String category;
  final String description;
  final String image;
  final String price;
  final String rate;
  final String title;

  Product({
    required this.category,
    required this.description,
    required this.image,
    required this.price,
    required this.rate,
    required this.title,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      price: data['price'] ?? '',
      rate: data['rate'] ?? '',
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
      'image': image,
      'price': price,
      'rate': rate,
      'title': title,
    };
  }
}
