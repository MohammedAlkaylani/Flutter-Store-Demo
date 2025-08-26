class Product {
  final String name;
  final double price;
  final double? oldPrice;
  final String? discount;
  final double? rating;
  final int? reviewCount;
  final String image;
  final String description;

  Product({
    required this.name,
    required this.price,
    this.oldPrice,
    this.discount,
    this.rating,
    this.reviewCount,
    required this.image,
    required this.description,
  });
}

class CartItem {
  final String name;
  final double currentPrice;
  final double originalPrice;
  final String discount;
  final String color;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.currentPrice,
    required this.originalPrice,
    required this.discount,
    required this.color,
    required this.image,
    required this.quantity,
  });
}